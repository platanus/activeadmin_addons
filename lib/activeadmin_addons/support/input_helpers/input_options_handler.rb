module ActiveAdminAddons
  module InputOptionsHandler
    ATTRIBUTE_DEFINITIONS = {
      fields: { default: ["name"], formatter: :to_json },
      display_name: { default: "name" },
      minimum_input_length: { default: 1 }
    }

    def control_attributes
      @control_attributes ||= {}
    end

    def load_attr(attr_name, options = {})
      attr_options = attr_full_options(attr_name, options)
      value = get_attr_value(attr_name, attr_options)
      value = value.send(attr_options[:formatter]) if attr_options[:formatter]
      control_attributes["data-#{attr_name}"] = value
    end

    def load_class(class_attr)
      return control_attributes[:class] if class_attr.blank?
      class_attr = class_attr.delete(" ")
      control_attributes[:class] = ([control_attributes[:class]] + [class_attr]).compact.join(" ")
    end

    private

    def get_attr_value(attr_name, attr_options)
      value = attr_options[:value] || @options[attr_name]
      return value if value
      default_value = attr_options[:default]
      return unless default_value
      return default_value.call if default_value.is_a?(Proc)
      default_value
    end

    def attr_full_options(attr_name, attr_options)
      default_attr_options = ATTRIBUTE_DEFINITIONS[attr_name] || {}
      attr_options = attr_options || {}
      default_attr_options.merge(attr_options)
    end
  end
end
