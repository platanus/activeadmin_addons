# Markdown

## Markdown Column

Renders text as markdown in the index view.

You just need to use `markdown_column` method.

```ruby
index do
  markdown_column :description
end
```

## Markdown Row

Renders text as markdown in the show view.

You just need to use `markdown_row` method.

```ruby
show do
  attributes_table do
    markdown_row :description
  end
end
```

## Options

This builder uses [Redcarpet](https://github.com/vmg/redcarpet) to render the text. You can pass any Redcarpet options to it. Using the options `extensions` and `render_options` to modify existing [Redcarpet options](https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use).

```ruby
index do
  markdown_column :description, extensions: { footnotes: true }
end

index do
  markdown_column :description, render_options: { hard_wrap: true }
end
```

### Builder default options

The builder enables the following options by default to provide a plug-and-play experience:

#### Extensions
``` json
fenced_code_blocks: true
no_intra_emphasis: true
strikethrough: true
superscript: true
```

#### Render options

```json
filter_html: true,
hard_wrap: true
```
