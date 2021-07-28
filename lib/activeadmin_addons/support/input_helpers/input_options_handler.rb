module ActiveAdminAddons
  module InputOptionsHandler
    def control_attributes
      result = {}
      result[:class] = css_classes.compact.join(" ") if css_classes.any?

      data_attr_options.each do |attribute, item|
        result[:data] ||= {}
        result[:data][attribute] = formatted_option_value(item)
      end

      attr_options.each do |attribute, item|
        result[attribute] = formatted_option_value(item)
      end

      result
    end

    def data_attr_options
      @data_attr_options || {}
    end

    def attr_options
      @attr_options || {}
    end

    def css_classes
      @css_classes || []
    end

    def load_data_attr(attr_name, options = {})
      @data_attr_options ||= {}
      @data_attr_options[attr_name.to_sym] = load_option_attr(attr_name, options)
    end

    def load_attr(attr_name, options = {})
      @attr_options ||= {}
      @attr_options[attr_name.to_sym] = load_option_attr(attr_name, options)
    end

    def load_class(class_attr)
      @css_classes ||= []
      return if class_attr.blank?

      class_attr = class_attr.strip
      @css_classes << class_attr
      class_attr
    end

    def get_data_attr_value(attr_name)
      item = data_attr_options[attr_name.to_sym]
      return unless item

      item[:value]
    end

    private

    def formatted_option_value(item)
      return item[:value].send(item[:formatter]) if item[:formatter]

      item[:value]
    end

    def load_option_attr(attr_name, options)
      value = calculate_attr_value(attr_name, options)
      item = { value: value }
      item[:formatter] = options[:formatter] if options[:formatter].present?
      item
    end

    def calculate_attr_value(attr_name, attr_options)
      value = attr_options[:value] || @options[attr_name]

      if !empty_value?(value)
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

    def empty_value?(value)
      value.nil? || value == ""
    end
  end
end
