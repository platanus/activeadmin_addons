# Enum Integration

## Tag Row

```ruby
show do
  attributes_table do
    tag_row :state
  end
end
```

<img src="./images/enumerize-tag-row.png" height="140" />

## Tag Column

```ruby
index do
  tag_column :state
end
```

<img src="./images/enumerize-tag-column.png" height="250" />

If you want to customize the tag's colors. You need to define css classes matching enumerize attribute values. For example: if you have the `Bill` model with:

```ruby
class Bill < ActiveRecord::Base
  # Enumerize
  extend Enumerize
  enumerize :state, in: [:pending, :rejected, :approved], default: :pending

  # Rails Enum
  enum status: { active: 0, archived: 1 }
end
```

You will need to define inside `your_app/app/assets/stylesheets/active_admin.css.scss` the following:

```scss
$pending-color: #FF9900;
$rejected-color: #FF0000;
$approved-color: #08A510;

.status_tag {
  &.pending { background: $pending-color; }
  &.rejected { background: $rejected-color; }
  &.approved { background: $approved-color; }
}
```

## Interactive Tag Column

`tag_column` also can receive the boolean parameter `interactive`. If `interactive` is true, it will render a select2 input to change the value of the attribute when the tag is clicked:

```ruby
index do
  tag_column :state, interactive: true
  tag_column :status, interactive: true
end
```

<img src="./images/enumerize-interactive-tag-column.gif" height="250" />
