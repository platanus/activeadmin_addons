class TagsInput < Formtastic::Inputs::StringInput
  def input_html_options
    opts = {}
    opts[:class] = "select2-tags"
    super.merge(opts)
  end

  def to_html
    relation? ? render_tags_from_relation : render_tags
  end

  def relation?
    @object.send(attributized_method_name).respond_to?(:each) &&
      @options[:collection].class.name == "ActiveRecord::Relation"
  end

  def render_tags
    input_wrapping do
      [
        label_html,
        builder.text_field(method, tag_options)
      ].join("\n").html_safe
    end
  end

  def render_tags_from_relation
    virtual_input_name = build_virtual_attr

    input_wrapping do
      [
        label_html,
        render_hidden_items,
        builder.text_field(virtual_input_name, relation_tag_options)
      ].flatten.join("\n").html_safe
    end
  end

  def tag_options
    opts = input_html_options
    opts["data-collection"] = (@options[:collection] || []).to_json
    opts
  end

  def relation_tag_options
    opts = input_html_options
    opts["data-model"] = model_name
    opts["data-method"] = method

    if @options[:collection].class.name != "ActiveRecord::Relation"
      fail "collection must be an ActiveRecord::Relation instance"
    end

    opts["data-collection"] = @options[:collection].map do |item|
      { id: item.id, text: item.send((@options[:display_name] || "name")) }
    end.to_json

    opts
  end

  def build_virtual_attr
    attr_name = "#{method}_str"
    @object.singleton_class.send(:attr_accessor, attr_name) unless @object.respond_to?(attr_name)
    @object.send("#{attr_name}=", @object.send(method).join(","))
    attr_name.to_sym
  end

  def render_hidden_items
    prefix = "#{model_name}_#{method}"
    attr_name = "#{model_name}[#{method}][]"
    template.content_tag(:div, id: "#{prefix}_selected_values") do
      template.concat(
        builder.hidden_field(method, id: "#{prefix}_empty", name: attr_name, value: nil))
      @object.send(method).each do |item_id|
        attr_id = "#{prefix}_#{item_id}"
        template.concat(builder.hidden_field(method, id: attr_id, name: attr_name, value: item_id))
      end
    end
  end

  def model_name
    @object.class.to_s.underscore
  end
end
