module ActiveAdminAddons
  module InputHtmlHelpers
    include InputMethods

    def prefixed_method
      "#{model_name}_#{valid_method}"
    end

    def method_to_input_name
      "#{model_name}[#{valid_method}]"
    end

    def method_to_input_array_name
      "#{method_to_input_name}[]"
    end

    def method_to_input_id(id)
      raise "invalid input id" if id.blank?

      "#{prefixed_method}_#{id}"
    end

    def selected_values_id
      "#{prefixed_method}_selected_values"
    end

    def empty_input_id
      "#{prefixed_method}_empty"
    end

    def build_separator
      template.content_tag(:span, "-", class: "separator")
    end

    def build_hidden_control(id, name, value = nil)
      builder.hidden_field(
        valid_method,
        id: id,
        name: name,
        value: value
      )
    end

    def to_html
      load_input_class
      load_control_attributes
      render_custom_input
      if parts.any?
        input_wrapping { parts_to_html }
      else
        super
      end
    end

    def input_html_options
      # maxwidth and size are added by Formtastic::Inputs::StringInput
      # but according to the HTML standard these are not valid attributes
      # on the inputs provided by this module
      super.except(:maxlength, :size).merge(control_attributes)
    end

    def load_input_class
      load_class(self.class.to_s.underscore.dasherize)
    end

    def load_control_attributes
      # Override on child classes if needed
    end

    def render_custom_input
      # Override on child classes if needed
    end

    def parts_to_html
      parts.flatten.join("\n").html_safe # rubocop:disable Rails/OutputSafety
    end

    def concat(part)
      parts << part
    end

    def parts
      @parts ||= []
    end
  end
end
