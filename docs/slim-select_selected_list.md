# Slim Select

## Selected List

This form control allows you to handle your many to many associations.

If, for example, you have something like this:

```ruby
class Event < ActiveRecord::Base
  has_and_belongs_to_many :performers
end

class Performer < ActiveRecord::Base
  has_and_belongs_to_many :events
end
```

In the ActiveAdmin's Event form, you can add:

```ruby
f.input :performer_ids, as: :selected_list
```

To get...

<img src="./images/slim-select-selected-list.gif" />

> Remember: the input name must be: `performer_ids` not `performers` and you need to add to `permit_params` the `performer_ids: []` key.

### Options

* `url`: **(optional)** This is the URL where to get the results. This URL expects an activeadmin collection Url (like the index action) or anything that uses [ransack](https://github.com/activerecord-hackery/ransack) search gem. By default, the url will be inferred from the attribute. In the example: `GET /admin/performers`.
* `response_root`: **(optional)** If a request to `url` responds with root, you can indicate the name of that root with this attribute. By default, the gem will try to infer the root from url. For example: if `url` is `GET /admin/performers`, the root will be `performers`. If you have a rootless api, you don't need to worry about this attribute.
* `minimum_input_length`: **(optional)** Minimum number of characters required to initiate the search. It **defaults to**: `1`
* `fields`: **(optional)** An array of field names where to search for matches in the related model. If we give many fields, they will be searched with an OR condition.
* `display_name`: **(optional)** You can pass an optional `display_name` to set the attribute to show results on the select. It **defaults to**: `name`.
* `width`: **(optional)** You can set the select input width (px or %).
* `order_by`: **(optional)** Order (sort) results by a specific attribute, suffixed with `_desc` or `_asc`. Eg: `description_desc`. By **default** is used the first field in descending direction.
* `predicate`: **(optional)** You can change the default [ransack predicate](https://github.com/activerecord-hackery/ransack#search-matchers). It **defaults to** `cont`
