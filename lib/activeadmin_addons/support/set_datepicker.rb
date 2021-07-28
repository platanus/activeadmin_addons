module ::Formtastic
  module Helpers
    module InputHelper
      alias_method :original_default_input_type, :default_input_type

      def default_input_type(method, options = {})
        input_type = original_default_input_type(method, options)

        if input_type == :date_select && active_admin_context?
          input_type = :datepicker
        end

        input_type
      end

      def active_admin_context?
        options[:builder] == ::ActiveAdmin::FormBuilder
      rescue NameError
        false
      end
    end
  end
end
