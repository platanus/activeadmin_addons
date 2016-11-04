# Select2

## Ajax Search

To enable select2 ajax search functionality you need to do the following:

```ruby
  f.input :category_id, as: :search_select, url: admin_categories_path,
          fields: [:name, :description], display_name: 'name', minimum_input_length: 2
```

<img src="./images/select2-search-select.gif" />

### Options

* `category_id`: Notice we're using the relation field name, not the realtion itself, so you can't use `f.input :category`.
* `url`: This is the URL where to get the results. This URL expects an activeadmin collection Url (like the index action) or anything that uses [ransack](https://github.com/activerecord-hackery/ransack) search gem.
* `response_root`: **(optional)** If a request to `url` responds with root, you can indicate the name of that root with this attribute. By default, the gem will try to infer the root from url. For example: if `url` is `GET /admin/categories`, the root will be `categories`. If you have a rootless api, you don't need to worry about this attribute.
* `fields`: an array of field names where to search for matches in the related model (`Category` in this example). If we give many fields, they will be searched with an OR condition.
* `display_name`: **(optional)** You can pass an optional `display_name` to set the field to show results on the select. This will be the field read from the object on loading the form and also when reading data from the ajax response(on the JSON). It **defaults to**: `name`
* `minimum_input_length`: **(optional)** Minimum number of characters required to initiate the
  search. It **defaults to**: `1`
* `class`: **(optional)** You can pass extra classes for your field.
* `multiple`: **(optional)** Set it to true if you need to select few options like tags select

<img src="./images/select2-tags.gif" />
