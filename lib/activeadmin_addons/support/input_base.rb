require_relative "input_helpers/input_options_handler"
require_relative "input_helpers/input_methods"
require_relative "input_helpers/input_html_helpers"

module ActiveAdminAddons
  class InputBase < Formtastic::Inputs::StringInput
    include InputOptionsHandler
    include InputMethods
    include InputHtmlHelpers
  end
end
