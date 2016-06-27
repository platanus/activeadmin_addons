class NestedSelectInput < Formtastic::Inputs::StringInput
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

    hierarchy.each_with_index do |level_data, idx|
      next_idx = idx + 1
      parent_level_data = hierarchy[next_idx] if hierarchy_count != next_idx
      level_data[:parent_attribute] = parent_level_data[:attribute] if parent_level_data

      yield(level_data)
    end
  end

  def get_hierarchy
    hierarchy = []
    levels = @options.keys.select { |key| key.to_s.match(/level_[1-9]$/) }
    reversed_levels = levels.reverse

    reversed_levels.each_with_index do |level_key, idx|
      previous_level_key = reversed_levels[idx + 1]
      validate_level_data!(level_key, previous_level_key)
      hierarchy << @options[level_key]
    end

    raise("Undefined levels on nested_select") if hierarchy.empty?

    hierarchy
  end

  def validate_level_data!(level_key, previous_level_key)
    current_level_number = get_level_number(level_key)
    previous_level_number = get_level_number(previous_level_key)

    if !(current_level_number == previous_level_number + 1)
      raise("Missing :level_#{current_level_number - 1} key")
    end

    attribute = @options[level_key][:attribute]
    raise("Missing mandatory attribute level_key on #{level_key}") unless attribute
  end

  def get_level_number(level_key)
    level_key.to_s.split("_").last.to_i
  end

  def select_html_options(level)
    attribute = level[:attribute]
    instance = instance_from_attribute_name(attribute)

    opts = {}
    opts["class"] = select_classes(level)
    opts["data-fields"] = get_option(level, :fields, ["name"]).to_json
    opts["data-model"] = model_name
    opts["data-display_name"] = get_option(level, :display_name,  "name")
    opts["data-minimum_input_length"] = get_option(level, :minimum_input_length, 1)
    opts["data-collection"] = (level[:collection] || nil).to_json

    opts["id"] = build_select_id(attribute)
    opts["data-url"] = get_option(level, :url, build_url(attribute))
    opts["data-response_root"] = (level[:response_root] || opts["data-url"].to_s.split('/').last)
    opts["data-selected"] = instance.try(opts["data-display_name"])

    opts.merge(select_html_parent_options(level[:parent_attribute]))
  end

  def select_html_parent_options(parent_attribute)
    opts = {}
    return opts unless parent_attribute
    opts["data-parent"] = parent_attribute
    opts["data-parent_id"] = @object.send(parent_attribute)
    opts
  end

  def select_classes(level_data)
    ['select2-ajax'].concat(get_option(level_data, :class, [])).join(' ')
  end

  def model_name
    @object.class.to_s.underscore.tr("/", "_")
  end

  def build_select_id(attribute)
    [model_name, attribute.to_s].join("_")
  end

  def get_option(level_data, option, default)
    level_data[option] || @options[option] || default
  end

  def set_parent_value(level_data)
    parent_attribute = level_data[:parent_attribute]
    return unless parent_attribute
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
    klass = attribute.to_s.chomp("_id").camelize.constantize
    klass.find_by_id(attribute_value)
  end

  def add_virtual_accessor(attribute)
    return unless attribute
    @object.singleton_class.send(:attr_accessor, attribute) unless @object.respond_to?(attribute)
  end

  def translated_attribute(attribute)
    @object.class.human_attribute_name(attribute)
  end

  def build_url(attribute)
    url = ["/"]

    if ActiveAdmin.application.default_namespace.present?
      url << "#{ActiveAdmin.application.default_namespace}/"
    end

    url << attribute.to_s.chomp("_id").tableize

    url.join("")
  end
end
