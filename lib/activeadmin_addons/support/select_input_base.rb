require_relative "input_helpers/input_options_handler"
require_relative "input_helpers/input_methods"
require_relative "input_helpers/input_html_helpers"

module ActiveAdminAddons
  class SelectInputBase < Formtastic::Inputs::SelectInput
    include InputOptionsHandler
    include InputMethods
    include InputHtmlHelpers
  end
end
