# ActiveAdmin UI Addons

Set of addons to help with the activeadmin ui

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

### Boolean values

#### Bool Row

Modifies how boolean values are displayed in attributes_table control (the one used in show view)

| key | value |
|------|------|
| paid | &#x2717; |
| subscribed | &#x2714; |

[Read more!](docs/bool_row.md)

#### Bool Column

Modifies how boolean values are displayed in index view

| id | name | paid | subscribed |
|------|------|------|------|
| 123 | Felipe | &#x2717; | &#x2714; |

[Read more!](docs/bool_column.md)

### Select2

#### Default

With [select2](http://ivaynberg.github.io/select2/) the select control looks nicer, it works great with large collections and multiple selection.

<img src="./docs/images/select2-example.png" height="200" />

[Read more!](docs/select2_default.md)

#### Tagging

Using tags input, you can add tags using select2.

<img src="./docs/images/select2-tags-example.png" height="100" />

[Read more!](docs/select2_tags.md)

#### Ajax Search

Using `search_select` input, you can easly add ajax search to activeadmin

<img src="./docs/images/select2-ajax-example.png" height="100" />

[Read more!](docs/select2_search.md)

### Paperclip Integration

#### For Images

Displays a paperclip image into index and show views.

<img src="./docs/images/paperclip-image-column-example.png" height="200" />

[Read more!](docs/paperclip_images.md)

#### For Any Attachment

Displays a paperclip link with attachment related icon into index and show views.

<img src="./docs/images/paperclip-attachment-column-example.png" height="250" />

[Read more!](docs/paperclip_attachment.md)

### Enumerize Integration

You can show [enumerize](https://github.com/brainspec/enumerize) values as active admin tags.

<img src="./docs/images/enumerize-tag-column-example.png" height="150" />

[Read more!](docs/enumerize_integration.md)

### Number Formatting

You can show numbers with format supported by [Rails NumberHelper](http://apidock.com/rails/v4.2.1/ActionView/Helpers/NumberHelper)

<img src="./docs/images/number-column-example.png" height="150" />

[Read more!](docs/number.md)

### List

You can show `Array` or `Hash` values as html lists.

<img src="./docs/images/list-row-example.png" height="150" />

[Read more!](docs/list.md)
