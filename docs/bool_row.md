# Bool Row

Modifies how boolean values are displayed in attributes_table control (the one used in show view)

| key | value |
|------|------|
| paid | &#x2717; |
| subscribed | &#x2714; |

You just need to use bool_row method

```ruby
show do
  attributes_table do
    row :id
    row :name
    bool_row :paid
    bool_row :subscribed
  end
end
```

## i18n Support

#### The default value is

* true: &#x2717;
* false: &#x2714;

#### Modifing the default

```
en:
  activeadmin:
    addons:
      boolean:
        default:
          true_value: ok
          false_value: nope
```

#### Modifing a specific model

```
en:
  activeadmin:
    addons:
      boolean:
        models:
          invoice:
            true_value: pagada
            false_value: no pagada
```
