# ActiveAdmin Addons [![Build Status](https://secure.travis-ci.org/platanus/activeadmin_addons.svg?branch=master)](http://travis-ci.org/platanus/activeadmin_addons)

ActiveAdmin Addons will extend your ActiveAdmin and enable a set of addons you can optionally use to improve the ActiveAdmin UI and make it awesome.

## What you get:

  - [Range Filter](#range-filter): Filter your results using a numeric range (i.e. age between 18-30).
  - [Select2](#select2): Cool select boxes for everyone.
  - [Paperclip Integration](#paperclip-integration): Show thumbnails or icons on your lists.
  - [AASM Integration](#aasm-integration): Nice looking tags for states.
  - [Enum Integration](#enum-integration): Nice looking tags for enums.
  - [Boolean Values](#boolean-values): Beautiful boolean values.
  - [Number Formatting](#number-formatting): Format you currencies with ease.
  - [List](#list): Show Arrays or Hashes like a list.
  - [Color Picker](#color-picker): Select colors from a pretty popup.
  - [Date Time Picker](#date-time-picker): Pick date and time comfortably.


**Table of Contents**

- [Installation](#installation)
- [Default changes to behaviour](#default-changes-to-behaviour)
- [Addons](#addons)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activeadmin_addons'
```

And then execute:

```bash
$ bundle
```

After that, run the generator:

```bash
$ rails g activeadmin_addons:install
```

check [here](docs/install_generator.md) to see more information about this generator.

## Default changes to behaviour

Installing this gem will enable the following changes by default:

* The default date input will be `:datepicker` instead of `:date_select`
* Filters and selects will offer integration with [enumerize](https://github.com/brainspec/enumerize)
* All select boxes will use select2

## Addons

### Range Filter

To filter based on a range of values you can use `range_select` like this:

```ruby
filter :number, as: :range_select
```

<img src="./docs/images/filter-range.png" height="150" />

### Select2

#### Default

With [select2](http://ivaynberg.github.io/select2/) the select control looks nicer, it works great with large collections and multiple selection.

<img src="./docs/images/select2-default.gif" height="200" />

[Read more!](docs/select2_default.md)

#### Tagging

Using tags input, you can add tags using select2.

<img src="./docs/images/select2-tags.gif" height="200" />

[Read more!](docs/select2_tags.md)

#### Ajax Search

Using `search_select` input, you can easily add ajax search to activeadmin

<img src="./docs/images/select2-search-select.gif" height="180" />

[Read more!](docs/select2_search.md)

#### Nested Select

Using `nested_select` input, you can build related select inputs.

<img src="./docs/images/select2-nested-select-default.gif" height="230" />

[Read more!](docs/select2_nested_select.md)

### Paperclip Integration

#### For Images

Displays a paperclip image into index and show views

<img src="./docs/images/paperclip-image-column.png" height="380" />

[Read more!](docs/paperclip_images.md)

#### For Any Attachment

Displays a paperclip link with attachment related icon into index and show views.

<img src="./docs/images/paperclip-attachment-column.png" height="250" />

[Read more!](docs/paperclip_attachment.md)

### AASM Integration

You can show [aasm](https://github.com/aasm/aasm) values as active admin tags.

<img src="./docs/images/aasm-integration-row.png" height="150" />

[Read more!](docs/aasm_integration.md)

### Enum Integration

You can show Rails' built in `enums` or [enumerize](https://github.com/brainspec/enumerize) values as active admin tags.

<img src="./docs/images/enumerize-tag-column.png" height="250" />

[Read more!](docs/enum_integration.md)

### Boolean Values

Modifies how boolean values are displayed

<img src="./docs/images/bool-column.png" height="250" />

[Read more!](docs/boolean_values.md)

### Number Formatting

You can show numbers with format supported by [Rails NumberHelper](http://apidock.com/rails/v4.2.1/ActionView/Helpers/NumberHelper)

<img src="./docs/images/number-column.png" height="250" />

[Read more!](docs/number-formatting.md)

### List

You can show `Array` or `Hash` values as html lists.

<img src="./docs/images/list-row.png" height="250" />

[Read more!](docs/list.md)

### Color Picker

You can pick colors using [JQuery Palette Color Picker](https://github.com/carloscabo/jquery-palette-color-picker)

```ruby
f.input :color, as: :color_picker
```

<img src="./docs/images/color-picker.gif" height="280" />

[Read more!](docs/color-picker.md)

### Date Time Picker

You can pick dates with time using the xdan's [jQuery Plugin Date and Time Picker](https://github.com/xdan/datetimepicker)

```ruby
f.input :updated_at, as: :date_time_picker
```

<img src="./docs/images/date-time-picker.gif" height="280" />

[Read more!](docs/date-time-picker.md)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/activeadmin_addons/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

activeadmin_addons is maintained by [platanus](http://platan.us).

## License

ActiveAdminAddons is © 2016 Platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
