require_relative "input_helpers/input_options_handler"
require_relative "input_helpers/input_methods"
require_relative "input_helpers/input_html_helpers"

module ActiveAdminAddons
  class InputBase < Formtastic::Inputs::StringInput
    include InputOptionsHandler
    include InputMethods
    include InputHtmlHelpers

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

    def parts_to_html
      parts.flatten.join("\n").html_safe
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

    def parts
      @parts ||= []
    end

    def concat(part)
      parts << part
    end
  end
end
