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

#### Image column

```ruby
index do
  # another attributes...
  image_column :photo, style: :thumb
end
```
> You can pass `style` attribute matching paperclip's style definition
