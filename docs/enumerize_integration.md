### Enumerize Integration

#### Tag Row

```ruby
show do
  attributes_table do
    # another attributes...
    tag_row :state
  end
end
```

#### Tag Column

```ruby
index do
  # another attributes...
  tag_column :state
end
```

If you want to customize the tag's colors. You need to define css classes matching enumerize attribute values. For example: if you have the `Bill` model with:

```ruby
class Bill < ActiveRecord::Base
  extend Enumerize
  enumerize :state, in: [:rejected, :approved]
end
```

You will nedd to define inside `your_app/app/assets/stylesheets/active_admin.css.scss` the following:

```scss
status_tag {
  &.rejected { background: $rejected-color; }
  &.approved { background: $approved-color; }
}
```
