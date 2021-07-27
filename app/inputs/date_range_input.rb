class DateRangeInput < ActiveAdmin::Inputs::Filters::DateRangeInput
  if instance_methods(true).include?(:input_html_options_for)
    def input_html_options
      super.except(:maxlength, :size).merge(autocomplete: 'off')
    end
  else
    def input_html_options(input_name = gt_input_name, placeholder = gt_input_placeholder)
      super(input_name, placeholder).except(:maxlength, :size).merge(autocomplete: 'off')
    end
  end
end
