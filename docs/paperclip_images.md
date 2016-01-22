# Paperclip Integration

## Image Row

```ruby
show do
  attributes_table do
    image_row :photo
  end
end
```

<img src="./images/paperclip-image-row.png" height="400" />

## Image Column

```ruby
index do
  image_column :photo, style: :thumb
end
```

<img src="./images/paperclip-image-column.png" height="400" />

> You can pass `style` attribute matching paperclip's style definition
