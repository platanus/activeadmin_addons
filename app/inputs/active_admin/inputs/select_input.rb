class ActiveAdmin::Inputs::SelectInput < Formtastic::Inputs::SelectInput
  def input_html_options
    super.merge(data: { tags: @options[:tags].present? })
  end
end
