class DateTimePickerFilterInput < ActiveAdminAddons::InputBase
  include ActiveAdminAddons::FilterInput

  def load_control_attributes
    load_attr(:picker_options, default: {})
  end

  def render_custom_input
    concat(label_html)
    concat_date_time_picker_field(gteq_input_name)
    concat_date_time_picker_field(lteq_input_name)
  end

  def concat_date_time_picker_field(control_name)
    concat(builder.input(control_name, date_time_picker_options(control_name)))
  end

  def date_time_picker_options(input_name = gteq_input_name)
    is_gt = (input_name == gteq_input_name)

    input_html_options.merge(
      as: :date_time_picker,
      placeholder: is_gt ? "min" : "max"
    )
  end
end
