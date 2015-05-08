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

## Default behaviour

* This gem changes the default ActiveAdmin's input type for date attributes from `:date_select` to `:datepicker`

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

[Read more!](docs/select2_default.md)

#### Tagging

Using tags input, you can add tags using select2.

[Read more!](docs/select2_tags.md)

#### Ajax Search

Using `search_select` input, you can easly add ajax search to activeadmin

[Read more!](docs/select2_search.md)

### Paperclip Integration

#### For Images

Displays a paperclip image into index and show views.

[Read more!](docs/paperclip_images.md)

#### For Any Attachment

Displays a paperclip link with attachment related icon into index and show views.

[Read more!](docs/paperclip_attachment.md)

#### Enumerize Integration

You can show [enumerize](https://github.com/brainspec/enumerize) values as active admin tags.

[Read more!](docs/enumerize_integration.md)
