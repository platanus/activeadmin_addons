class SearchSelectFilterInput < SearchSelectInput
  include ActiveAdminAddons::FilterInput

  def load_control_attributes
    super
    load_data_attr(:width, default: "resolve")
  end

  def input_method
    if @options.dig(:input_html, :multiple)
      in_input_name
    else
      eq_input_name
    end
  end
end
