# ActiveAdmin Addons [![Build Status](https://secure.travis-ci.org/platanus/activeadmin_addons.svg?branch=master)](http://travis-ci.org/platanus/activeadmin_addons)

Set of addons to improve the activeadmin ui and make it as awesome as we can.

**Table of Contents**

- [Instalation](#instalation)
- [Setup](#setup)
- [Default behaviour Changes](#default-behaviour-changes)
- [Addons](#addons)
	- [Filters](#filters)
		- [Range Filter](#range-filter)
	- [Select2](#select2)
		- [Default](#default)
		- [Tagging](#tagging)
		- [Ajax Search](#ajax-search)
		- [Nested Select](#nested-select)
	- [Paperclip Integration](#paperclip-integration)
		- [For Images](#for-images)
		- [For Any Attachment](#for-any-attachment)
	- [AASM Integration](#aasm-integration)
	- [Enum Integration](#enum-integration)
	- [Boolean Values](#boolean-values)
	- [Number Formatting](#number-formatting)
	- [List](#list)

## Instalation

Add this line to your application's Gemfile:

```ruby
gem 'activeadmin_addons'
```

And then execute:

```bash
$ bundle
```

## Setup

The **first** line in `app/assets/stylesheets/active_admin.css.scss` should be:

```stylesheet
//= require activeadmin_addons/all
```

In `app/assets/javascripts/active_admin.js.coffee` add this line **after** `#= require active_admin/base`

```javascript
#= require activeadmin_addons/all
```

## Default behaviour Changes

Installing this gem...

* The default date input will be `:datepicker` instead of `:date_select`
* Add better integration with [enumerize](https://github.com/brainspec/enumerize) on filters and selects

## Addons

### Filters

#### Range Filter

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
