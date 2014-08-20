### Bool Column

Modifies how boolean values are displayed in index view

| id | name | paid | subscribed |
|------|------|------|------|
| 123 | Felipe | &#x2717; | &#x2714; |

You just need to use bool_column method

```ruby
index do
  column :id
  column :name
  bool_column :paid
  bool_column :subscribed
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
