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
