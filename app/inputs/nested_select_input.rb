class NestedSelectInput < Formtastic::Inputs::StringInput
  def input_html_options
    opts = {}
    opts["class"] = ['select2-ajax'].concat([@options[:class]] || []).join(' ')
    opts["data-fields"] = (@options[:fields] || []).to_json
    opts["data-model"] = @object.class.to_s.downcase
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1

    super.merge(opts)
  end

  def to_html
    hierarchy = @options.fetch(:parents, [])
    hierarchy.unshift input_name
    html_elems = []

    hierarchy.each_with_index do |attribute, idx|
      parent_attribute = hierarchy[idx + 1]
      add_virtual_accessor(parent_attribute)
      set_parent_value(attribute, parent_attribute)
      html_elems << builder.text_field(attribute, select_html_options(attribute, parent_attribute))
      html_elems << builder.label(attribute, translated_attribute(attribute))
    end

    input_wrapping do
      html_elems.reverse.join("\n").html_safe
    end
  end

  private

  def select_html_options(attribute, parent_attribute)
    instance = get_attribute_instance(attribute)

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

  def set_parent_value(attribute, parent_attribute)
    instance = get_attribute_instance(attribute)
    if instance && instance.respond_to?(parent_attribute)
      @object.send("#{parent_attribute}=", instance.send(parent_attribute))
    end
  end

  def get_attribute_instance(attribute)
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
