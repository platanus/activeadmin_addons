class SelectedListInput < Formtastic::Inputs::StringInput
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def input_html_options
    opts = {}
    opts[:class] = ["selected-list"].concat([@options[:class]] || []).join(' ')
    opts["data-model"] = model_name
    opts["data-method"] = method
    opts["data-url"] = @options[:url] || build_url
    opts["data-response_root"] = @options[:response_root] || opts["data-url"].split('/').last
    opts["data-fields"] = (@options[:fields] || ["name"]).to_json
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1
    opts["data-width"] = @options[:width] if @options[:width]
    opts["data-order"] = @options[:order_by] if @options[:order_by]
    super.merge(opts)
  end

  def to_html
    input_wrapping do
      [
        builder.label(translated_attribute(method), class: "selected-list-label"),
        render_control_wrapper
      ].flatten.join("\n").html_safe
    end
  end

  def render_control_wrapper
    template.content_tag(:div, class: "selected-list-container") do
      template.content_tag(label_html)
      template.concat(render_items_list)
      template.concat(builder.text_field(virtual_attr, input_html_options))
    end
  end

  def render_items_list
    prefix = "#{model_name}_#{method}"
    attr_name = "#{model_name}[#{method}][]"
    template.content_tag(:div, id: "#{prefix}_selected_values", class: "selected-values") do
      template.concat(
        builder.hidden_field(method, id: "#{prefix}_empty", name: attr_name, value: nil)
      )
      @object.send(method).each do |item_id|
        template.concat(render_item_label(prefix, attr_name, item_id))
      end
    end
  end

  def render_item_label(prefix, attr_name, item_id)
    attr_id = "#{prefix}_#{item_id}"
    div_config = { id: attr_id, class: "selected-item" }
    template.content_tag(:div, div_config) do
      template.concat(item_label(item_id))
      template.concat(builder.hidden_field(nil, id: nil, name: attr_name, value: item_id))
    end
  end

  def item_label(item_id)
    selected_items.find { |item| item.id == item_id }.send(@options[:display_name] || "name")
  end

  def selected_items
    @selected_items ||= @object.send(relation_name)
  end

  def translated_attribute(attribute)
    @object.class.human_attribute_name(attribute)
  end

  def model_name
    @object.class.to_s.underscore.tr('/', '_')
  end

  def virtual_attr
    attr_name = "#{method}_str".to_sym
    @object.singleton_class.send(:attr_accessor, attr_name) unless @object.respond_to?(attr_name)
    attr_name
  end

  def build_url
    url = ["/"]

    if ActiveAdmin.application.default_namespace.present?
      url << "#{ActiveAdmin.application.default_namespace}/"
    end

    url << relation_name

    url.join("")
  end

  def relation_name
    method.to_s.chomp("_ids").tableize
  end
end
