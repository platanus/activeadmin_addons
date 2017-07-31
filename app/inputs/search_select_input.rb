class SearchSelectInput < ActiveAdminAddons::InputBase
  include ActiveAdminAddons::SelectHelpers

  def render_custom_input
    concat(label_html)
    concat(builder.select(method, [[nil]], {}, input_html_options))
  end

  def load_control_attributes
    load_class("search-select")
    load_class(@options[:class])
    load_attr(:collection, value: collection_to_select_options)
    load_attr(:fields)
    load_attr(:url, default: url_from_method)
    load_attr(:response_root, default: tableize_method)
    load_attr(:display_name)
    load_attr(:minimum_input_length)
    load_attr(:width)
    load_attr(:order, value: @options[:order_by])
  end
end
