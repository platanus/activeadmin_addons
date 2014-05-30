# For the Gem

## Fancy Boolean

In config/initializers/active_admin.rb

```
module ActiveAdmin
  module Views
    class TableFor
      def bool_column(attribute)
        column(attribute){ |model| model[attribute] ? '&#x2714;'.html_safe : '&#x2717;'.html_safe }
      end
    end
    class AttributesTable
      def bool_row(attribute)
        row(attribute){ |model| model[attribute] ? '&#x2714;'.html_safe : '&#x2717;'.html_safe }
      end
    end
  end
end
```

## Select2

1. Add select2-rails to the Gemfile:

```
gem 'select2-rails'
```

2. `bundle install`
3. In active_admin.css.scss:

```
//= require select2
```

4. In active_admin.js.coffee:

```
#= require select2
```

5. In a js file.

```
$ ->
  $('select:not(.no-widget)').each (i, el) ->
    if $(el).closest('.filter_form').length > 0
      $(el).select2(width: 'resolve')
    else
      $(el).select2(width: '80%')
```

# TODO
- Make activeadmin date input to default to `date_picker` instead of `date`.
- DatePicker locale configuration (Research and Fix)

# Tips

## Add a Filter for Multiple Values

```
filter :communes, multiple: true
```

## Custom Filters (Ransackers)

Use this when you have to not search for a field but a method. Something like search for full name:

1. Add a Ransacker in the model class:
```
class User
  # ...
  ransacker :full_name do
    Arel.sql('CONCAT(first_name, ' ', last_name)')
  end
  # ...
end
```

2. Add the filter in the activeadmin resource page:

```
filter :full_name_cont
```

More about Ransackers: <https://github.com/activerecord-hackery/ransack/wiki/Using-Ransackers>
