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

<img src="./images/paperclip-attachment-row-example.png" height="200" />

#### Attachment Column

```ruby
index do
  # another attributes...
  attachment_column :document, truncate: false
end
```

<img src="./images/paperclip-attachment-column-example.png" height="300" />

> You can pass `truncate` attribute to toggle truncating the filename. `attachment_column` truncates by default, while `attachment_row` doesn't
