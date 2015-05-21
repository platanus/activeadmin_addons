### Number Formatting

#### Number Row

```ruby
show do
  attributes_table do
    # another attributes...
    number_row :amount, as: :currency
  end
end
```

<img src="./images/number-row-example.png" height="200" />

#### Number Column

```ruby
index do
  # another attributes...
  number_row :profit, as: :percentage
end
```

<img src="./images/number-column-example.png" height="150" />

#### Options

If you want to customize the default number format, you can pass the same options passed to [Rails NumberHelper](http://apidock.com/rails/v4.2.1/ActionView/Helpers/NumberHelper) methods. For example:

```ruby
show do
  attributes_table do
    # another attributes...
    number_row :amount, as: :currency, unit: "R$", separator: ","
  end
end
```
