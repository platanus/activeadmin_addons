class SelectedListInput < ActiveAdminAddons::InputBase
  def render_custom_input
    concat(builder.label(translated_method, class: "selected-list-label"))
    concat(render_control_wrapper)
  end

  def load_control_attributes
    load_class("selected-list")
    load_class(@options[:class])
    load_attr(:model, value: model_name)
    load_attr(:method, value: method)
    load_attr(:url, default: url_from_method)
    load_attr(:response_root, default: tableize_method)
    load_attr(:fields)
    load_attr(:display_name)
    load_attr(:minimum_input_length)
    load_attr(:width)
    load_attr(:order, value: @options[:order_by])
  end

  private

  def render_control_wrapper
    template.content_tag(:div, class: "selected-list-container") do
      template.content_tag(label_html)
      template.concat(render_items_list)
      template.concat(builder.select(build_virtual_attr, [], {}, input_html_options))
    end
  end

  def render_items_list
    template.content_tag(:div, id: selected_values_id, class: "selected-values") do
      template.concat(build_hidden_control(empty_input_id, method_to_input_array_name, ""))
      input_related_items.each { |item| template.concat(render_item(item)) }
    end
  end

  def render_item(item)
    template.content_tag(:div, id: method_to_input_id(item.id), class: "selected-item") do
      template.concat(item_label(item))
      template.concat(
        build_hidden_control(method_to_input_id(item.id), method_to_input_array_name, item.id.to_s)
      )
    end
  end

  def item_label(item)
    item.send(@options[:display_name] || "name")
  end
end
