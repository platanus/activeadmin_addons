module ::Formtastic
  module Helpers
    module InputHelper
      alias_method :original_default_input_type, :default_input_type

      def default_input_type(method, options = {})
        input_type = original_default_input_type(method, options)
        input_type = :datepicker if input_type == :date_select
        input_type
      end
    end
  end
end
