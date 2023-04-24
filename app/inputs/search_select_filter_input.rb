class SearchSelectFilterInput < SearchSelectInput
  include ActiveAdminAddons::FilterInput

  def load_control_attributes
    super
    load_data_attr(:width, default: "resolve")
  end

  def input_method
    "#{input_name}_eq"
  end

  def input_html_options_name
    "#{object_name}[#{input_method}]"
  end

  def input_value
    result = valid_object.conditions.find do |condition|
      condition.attributes.map(&:name).include?(input_name.to_s)
    end

    return unless result

    result.values.first.value
  end
end
