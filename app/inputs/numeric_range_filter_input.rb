class NumericRangeFilterInput < ActiveAdminAddons::InputBase
  include ActiveAdminAddons::FilterInput

  def render_custom_input
    concat(label_html)
    concat_text_field(gteq_input_name)
    concat(build_separator)
    concat_text_field(lteq_input_name)
  end

  def concat_text_field(control_name)
    concat(builder.text_field(control_name, input_html_options(control_name)))
  end

  alias :input_name :gteq_input_name

  def input_html_options(input_name = gteq_input_name)
    is_gt = (input_name == gteq_input_name)

    {
      type: "number",
      step: "any",
      value: @object.public_send(input_name),
      placeholder: is_gt ? "min" : "max"
    }
  end
end
