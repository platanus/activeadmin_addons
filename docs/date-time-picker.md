# Date Time Picker

## Form

You can pick dates with time using the xdan's [jQuery Plugin Date and Time Picker](https://github.com/xdan/datetimepicker)

```ruby
form do |f|
  f.inputs "Details" do
    f.input :updated_at, as: :date_time_picker
  end

  f.actions
```

<img src="./images/date-time-picker.gif" height="280" />

## Options

You can pass to `picker_options`, all the options available on xdan's library. Notice `timepicker: false` to only show a date picker

```ruby
form do |f|
  f.inputs "Details" do
    f.input :updated_at, as: :date_time_picker,
                         picker_options: {
                           min_date: Date.current - 2.days,
                           allow_times: [
                             '12:10', '13:10', '15:10',
                             '17:10', '18:10', '19:10'
                           ],
                           timepicker: false
                         }
  end

  f.actions
```

## Overriding defaults

You can add, in a Rails initializer, default options like this:

```ruby
datetime_picker_input = Formtastic::Inputs::StringInput::DateTimePickerInput

# This if for front-end javascript side
datetime_picker_input.default_datetime_picker_options = {
  format: "d-m-Y H:i",
  step: 10 # minutes
}

# This if for backend (Ruby)
datetime_picker_input.format = "%d-%m-%Y %H:%M"
```
