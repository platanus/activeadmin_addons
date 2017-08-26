class SearchSelectFilterInput < SearchSelectInput
  include ActiveAdminAddons::FilterInput

  def load_control_attributes
    super
    load_data_attr(:width, default: "resolve")
  end

  def input_method
    eq_input_name
  end
end
