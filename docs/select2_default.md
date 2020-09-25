# Select2

## Default

As default behavior, all select controls in your admin app will be wrapped by [Select2](http://ivaynberg.github.io/select2/).

<img src="./images/select2-default.gif" height="200" />

If you don't want to use it in a specific control, just add the `"default-select"` class:

```
f.input :created_at, input_html: { class: "default-select" }
```

If you don't want all the select controls wrapped by select2, you can change the default behavior setting as `"default"` the `default_select` option in the initializer.

```ruby
ActiveadminAddons.setup do |config|
  config.default_select = "default"
end
```

Now, if you want to enable [select2](http://ivaynberg.github.io/select2/) for a single control, you can add the `"select2"` class:

```
f.input :created_at, input_html: { class: "select2" }
```

### Options

* `tags`: **(optional)** boolean option, by **default** it's `false`. If `true`, it allows dynamic option creation [as described here](https://select2.org/tagging). It will also add the input's initial value to the select options if it's not in the supplied collection. Note that, unlike the `tags_input`, this does not allow multiple values. Only available for form inputs, not filters.
