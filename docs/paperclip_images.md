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

![Paperclip Image](https://raw.githubusercontent.com/platanus/activeadmin_addons/master/docs/images/paperclip-image-row-example.png)

#### Image column

```ruby
index do
  # another attributes...
  image_column :photo, style: :thumb
end
```

![Paperclip Image](https://raw.githubusercontent.com/platanus/activeadmin_addons/master/docs/images/paperclip-image-column-example.png)

> You can pass `style` attribute matching paperclip's style definition
