# Select2

## Ajax Search

To enable select2 ajax search functionality you need to do the following:

```ruby
  f.input :category_id, as: :search_select, url: admin_categories_path,
          fields: [:name, :description], display_name: 'name', minimum_input_length: 2,
          order_by: 'description_asc'
```

<img src="./images/select2-search-select.gif" />

## Filter Usage

To use on filters you need to add `as: :search_select_filter` with same options.
If you want to use url helpers, use a `proc` like on the example

```ruby
  filter :category_id, as: :search_select_filter, url: proc { admin_categories_path },
         fields: [:name, :description], display_name: 'name', minimum_input_length: 2,
         order_by: 'description_asc'
```

In case you need to filter with an attribute of another table you need to include the `method_model` option. In the classic User has many Post's and Post has many Comment's example, in the Comment index you could add this filter:

```ruby
  filter :posts_user_id, as: :search_select_filter, url: proc { admin_users_path },
         fields: [:name, :email], display_name: 'email', minimum_input_length: 2,
         order_by: 'description_asc', method_model: User
```

### Options

* `category_id`: Notice we're using the relation field name, not the relation itself, so you can't use `f.input :category`.
* `url`: This is the URL where to get the results. This URL expects an activeadmin collection Url (like the index action) or anything that uses [ransack](https://github.com/activerecord-hackery/ransack) search gem.
* `response_root`: **(optional)** If a request to `url` responds with root, you can indicate the name of that root with this attribute. By default, the gem will try to infer the root from url. For example: if `url` is `GET /admin/categories`, the root will be `categories`. If you have a rootless api, you don't need to worry about this attribute.
* `fields`: an array of field names where to search for matches in the related model (`Category` in this example). If we give many fields, they will be searched with an OR condition.
* `display_name`: **(optional)** You can pass an optional `display_name` to set the field to show results on the select. This will be the field read from the object on loading the form and also when reading data from the ajax response(on the JSON). It **defaults to**: `name`
* `minimum_input_length`: **(optional)** Minimum number of characters required to initiate the
  search. It **defaults to**: `1`
* `class`: **(optional)** You can pass extra classes for your field.
* `width`: **(optional)** You can set the select input width (px or %).
* `order_by`: **(optional)** Order (sort) results by a specific attribute, suffixed with `_desc` or `_asc`. Eg: `description_desc`. By **default** is used the first field in descending direction.
* `predicate`: **(optional)** You can change the default [ransack predicate](https://github.com/activerecord-hackery/ransack#search-matchers). It **defaults to** `cont`.
* `method_model`: **(optional)** Use in case you need to search or filter an attribute of another table.
