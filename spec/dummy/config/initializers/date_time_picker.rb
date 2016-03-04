datetime_picker_input = Formtastic::Inputs::StringInput::DateTimePickerInput

# This if for front-end javascript side
datetime_picker_input.default_datetime_picker_options = {
  format: "d-m-Y H:i",
  step: 10 # minutes
}

# This if for backend (Ruby)
datetime_picker_input.format = "%d-%m-%Y %H:%M"
