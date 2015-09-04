class RangeSelectInput < Formtastic::Inputs::StringInput
  include ActiveAdmin::Inputs::Filters::Base

  def to_html
    input_wrapping do
      [
        label_html,
        builder.text_field(gt_input_name, input_html_options(gt_input_name)),
        template.content_tag(:span, "-", class: "separator"),
        builder.text_field(lt_input_name, input_html_options(lt_input_name)),
      ].join("\n").html_safe
    end
  end

  def gt_input_name
    "#{method}_gteq"
  end

  alias :input_name :gt_input_name

  def lt_input_name
    "#{method}_lteq"
  end

  def input_html_options(input_name = gt_input_name)
    is_gt = (input_name == gt_input_name)

    {
      type: "number",
      step: "any",
      value: @object.public_send(input_name),
      placeholder: is_gt ? "min" : "max"
    }
  end
end
