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

In case you have a nested resource you can use the custom option `:url` to change the default url, this option expects a path without the resource id. Let's say you have the `User` model that `has_many: :documents`, then the show method will look like this:

```ruby
# Admin User File
# ...
show do
  attributes_table do
    # ...
  end

  panel 'Documents' do
    table_for user.documents do
      tag_column(:state, intercative: true, url: '/admin/documents/')
    end
  end
end
```

Note that you have to add the `permit_params :state` in the admin `Document` file.
