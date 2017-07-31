class RangeDateTimePickerInput < DateTimePickerInput
  include ActiveAdmin::Inputs::Filters::Base

  def to_html
    input_wrapping do
      [
        label_html,
        builder.text_area(gt_input_name, input_html_options(gt_input_name)),
        builder.text_area(lt_input_name, input_html_options(lt_input_name))
      ].join("\n").html_safe
    end
  end

  def gt_input_name
    "#{method}_gteq"
  end

  def lt_input_name
    "#{method}_lteq"
  end
end
