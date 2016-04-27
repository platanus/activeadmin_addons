# Select2

## Tagging

To enable select2 with tags functionality you need to do the following:

```ruby
f.input :names, as: :tags
```

You can load previous created tags using `collection` option passing an array of strings like this:

```ruby
f.input :names, as: :tags, collection: ['Julio', 'Emilio', 'Leandro']
```

<img src="./images/select2-tags.gif" />

## Tagging with Active Record collections

To use tagging functionality with Active Record collections you need to do something like this:

```ruby
class Event < ActiveRecord::Base
  has_and_belongs_to_many :performers
end

class Performer < ActiveRecord::Base
  has_and_belongs_to_many :events
end
```

So, in the ActiveAdmin's Event form, you can add:

```ruby
f.input :performer_ids, as: :tags, collection: Performer.all, display_name: :full_name
```

> Remember: the input name must be: `performer_ids` not `performers` and you need to add to `permit_params` the `performer_ids: []` key.

### Options

* `display_name`: **(optional)** You can pass an optional `display_name` to set the attribute (or method) to show results on the select. It **defaults to**: `name`
