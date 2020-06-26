require_relative "filter_input_methods"

module ActiveAdminAddons
  module FilterInput
    include ActiveAdmin::Inputs::Filters::Base
    include FilterInputMethods
  end
end
