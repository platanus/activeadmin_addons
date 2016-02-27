class ColorPickerInput < Formtastic::Inputs::StringInput
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
    "#FFFFFF",
  ]

  def to_html
    input_wrapping do
      [
        label_html,
        builder.hidden_field(method, input_html_options),
      ].join("\n").html_safe
    end
  end

  def input_html_options
    opts = {}
    opts["class"] = 'color-picker'
    opts["data-palette"] = DEFAULT_PALETTE.to_json
    opts["value"] = @object.public_send(method)
    super.merge(opts)
  end
end
