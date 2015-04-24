### Select2 - Tagging

To enable select2 with tags functionality you need to do the following:

```ruby
f.input :hobbies, as: :tags
```

You can load previous created tags using `collection` option like this:

```ruby
f.input :hobbies, as: :tags, collection: ['Playing guitar', 'Watching Game of Thrones']
```
