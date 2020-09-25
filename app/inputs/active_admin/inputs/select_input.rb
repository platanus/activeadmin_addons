class ActiveAdmin::Inputs::SelectInput < Formtastic::Inputs::SelectInput
  def input_html_options
    super.merge(data: { tags: @options[:tags].present? })
  end

  def raw_collection
    field_value = object.send(method)

    @options[:tags].present? && field_value.present? ? (super.to_a << field_value).uniq : super
  end
end
