class DateRangeInput < ActiveAdmin::Inputs::Filters::DateRangeInput
  def input_html_options
    super.except(:maxlength, :size).merge({ autocomplete: 'off' })
  end
end
