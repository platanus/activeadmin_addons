### Paperclip Integration

#### Attachment Row

```ruby
show do
  attributes_table do
    # another attributes...
    attachment_row :document
  end
end
```

![Paperclip Attachment](https://raw.githubusercontent.com/platanus/activeadmin_addons/master/docs/images/paperclip-attachment-row-example.png)

#### Attachment Column

```ruby
index do
  # another attributes...
  attachment_column :document, truncate: false
end
```

![Paperclip Attachment](https://raw.githubusercontent.com/platanus/activeadmin_addons/master/docs/images/paperclip-attachment-column-example.png)

> You can pass `truncate` attribute to toggle truncating the filename. `attachment_column` truncates by default, while `attachment_row` doesn't
