class ColorPickerInput < ActiveAdminAddons::InputBase
  DEFAULT_PALETTE = [
    "#000000",
    "#333333",
    "#663300",
    "#CC0000",
    "#CC3300",
    "#FFCC00",
    "#009900",
    "#006666",
    "#0066FF",
    "#0000CC",
    "#663399",
    "#CC0099",
    "#FF9999",
    "#FF9966",
    "#FFFF99",
    "#99FF99",
    "#66FFCC",
    "#99FFFF",
    "#66CCFF",
    "#9999FF",
    "#FF99FF",
    "#FFCCCC",
    "#FFCC99",
    "#FFFFFF"
  ]

  def render_custom_input
    concat(label_html)
    concat(builder.hidden_field(method, input_html_options))
  end

  def load_control_attributes
    load_data_attr(:palette, default: DEFAULT_PALETTE, formatter: :to_json)
  end
end
