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
    hierarchy = @options.fetch(:parents, []).reverse
    hierarchy << input_name
    html_elements = []
    parent_attribute = nil

    hierarchy.each do |attribute|
      add_virtual_accessor(attribute) unless @object.respond_to?(attribute)
      html_elements << builder.label(attribute, translated_attribute(attribute))
      html_elements << builder.text_field(attribute,
        select_html_options(attribute, parent_attribute))
      parent_attribute = attribute
    end

    input_wrapping do
      html_elements.join("\n").html_safe
    end
  end

  private

  def select_html_options(attribute, parent_attribute)
    opts = input_html_options.clone
    opts["id"] = [@object.class.to_s.downcase, attribute.to_s].join("_")
    opts["data-parent"] = parent_attribute
    opts["data-url"] = build_url(attribute)
    opts
  end

  def add_virtual_accessor(attribute)
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
