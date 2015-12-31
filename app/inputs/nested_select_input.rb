class NestedSelectInput < Formtastic::Inputs::StringInput
  def input_html_options
    opts = {}
    opts["class"] = ['select2-ajax'].concat([@options[:class]] || []).join(' ')
    opts["data-fields"] = (@options[:fields] || ["name"]).to_json
    opts["data-model"] = @object.class.to_s.downcase
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1

    super.merge(opts)
  end

  def to_html
    html_elems = []

    for_each_level do |level_data|
      a = level_data[:attribute]
      set_parent_value(level_data)
      html_elems << builder.text_field(a, select_html_options(level_data))
      html_elems << builder.label(a, translated_attribute(a))
    end

    input_wrapping do
      html_elems.reverse.join("\n").html_safe
    end
  end

  private

  def for_each_level
    hierarchy = get_hierarchy
    hierarchy_count = hierarchy.count

    get_hierarchy.each_with_index do |level_data, idx|
      next_idx = idx + 1
      parent_level_data = hierarchy[next_idx] if hierarchy_count != next_idx
      level_data[:parent_attribute] = parent_level_data[:attribute] if parent_level_data

      yield(level_data)
    end
  end

  def get_hierarchy
    hierarchy = []
    levels = @options.keys.select { |key| key.to_s.start_with?("level") }
    levels_count = levels.count

    levels.reverse.each_with_index do |level, idx|
      level_number = levels_count - idx
      validate_level_data!(level, level_number)
      hierarchy << @options[level]
    end

    raise("Undefined levels on nested_select") if hierarchy.empty?

    hierarchy
  end

  def validate_level_data!(level_key, level_number)
    parts = level_key.to_s.split("_")
    raise("Invalid level format. Must be :level_[1|2|n]") unless parts.count == 2
    raise("Missing :level_#{level_number} key") if parts.last.to_i != level_number
    attribute = @options[level_key][:attribute]
    raise("Missing mandatory attribute level_key on #{level_key}") unless attribute
  end

  def select_html_options(level_data)
    attribute = level_data[:attribute]
    parent_attribute = level_data[:parent_attribute]
    instance = instance_from_attribute_name(attribute)

    opts = input_html_options.clone
    opts["id"] = [@object.class.to_s.downcase, attribute.to_s].join("_")
    opts["data-url"] = build_url(attribute)
    opts["data-selected"] = instance.try(opts["data-display_name"])

    if parent_attribute
      opts["data-parent"] = parent_attribute
      opts["data-parent_id"] = @object.send(parent_attribute)
    end

    opts
  end

  def set_parent_value(level_data)
    parent_attribute = level_data[:parent_attribute]
    add_virtual_accessor(parent_attribute)
    instance = instance_from_attribute_name(level_data[:attribute])
    if instance && instance.respond_to?(parent_attribute)
      @object.send("#{parent_attribute}=", instance.send(parent_attribute))
    end
  end

  def instance_from_attribute_name(attribute)
    return unless attribute
    attribute_value = @object.send(attribute)
    return unless attribute_value
    klass = attribute.to_s.humanize.constantize
    klass.find_by_id(attribute_value)
  end

  def add_virtual_accessor(attribute)
    return unless attribute
    @object.singleton_class.send(:attr_accessor, attribute)
  end

  def translated_attribute(attribute)
    @object.class.human_attribute_name(attribute)
  end

  def build_url(attribute)
    url = ["/"]

    if ActiveAdmin.application.default_namespace.present?
      url << "#{ActiveAdmin.application.default_namespace}/"
    end

    url << attribute.to_s.humanize.tableize

    url.join("")
  end
end
