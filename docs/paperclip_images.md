### Paperclip Integration

#### Image Row

```ruby
show do
  attributes_table do
    # another attributes...
    image_row :photo
  end
end
```

<img src="./images/paperclip-image-row-example.png" height="300" />

#### Image column

```ruby
index do
  # another attributes...
  image_column :photo, style: :thumb
end
```

<img src="./images/paperclip-image-column-example.png" height="200" />

> You can pass `style` attribute matching paperclip's style definition
