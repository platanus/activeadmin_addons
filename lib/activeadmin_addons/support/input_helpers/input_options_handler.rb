module ActiveAdminAddons
  module InputOptionsHandler
    def control_attributes
      @control_attributes ||= {}
    end

    def load_data_attr(attr_name, options = {})
      control_attributes["data-#{attr_name}"] = get_formatted_value(attr_name, options)
    end

    def load_attr(attr_name, options = {})
      control_attributes[attr_name] = get_formatted_value(attr_name, options)
    end

    def load_class(class_attr)
      return control_attributes[:class] if class_attr.blank?
      class_attr = class_attr.delete(" ")
      control_attributes[:class] = ([control_attributes[:class]] + [class_attr]).compact.join(" ")
    end

    private

    def get_formatted_value(attr_name, options)
      value = calculate_attr_value(attr_name, options)
      value = value.send(options[:formatter]) if options[:formatter]
      value
    end

    def calculate_attr_value(attr_name, attr_options)
      value = attr_options[:value] || @options[attr_name]

      if value
        if value.is_a?(Proc)
          return template.instance_eval(&value)
        else
          return value
        end
      end

      default_value = attr_options[:default]
      return unless default_value
      return default_value.call if default_value.is_a?(Proc)
      default_value
    end
  end
end
