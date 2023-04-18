class ActiveAdmin::Inputs::SelectInput < Formtastic::Inputs::SelectInput
  def input_html_options
    if @options[:tags].present?
      super.deep_merge(class: 'simple-tags-input')
    else
      super
    end
  end

  def raw_collection
    field_value = begin
      object.send(method)
    rescue NoMethodError
      nil
    end

    @options[:tags].present? && field_value.present? ? (super.to_a << field_value).uniq : super
  end
end
