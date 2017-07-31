class NestedLevelInput < ActiveAdminAddons::InputBase
  include ActiveAdminAddons::SelectHelpers

  def render_custom_input
    concat(label_html)

    select_control = builder.select(
      method, initial_collection_to_select_options, {}, input_html_options
    )

    concat(select_control)
  end

  private

  def load_control_attributes
    load_class("nested-select")
    load_class(@options[:class])
    load_attr(:fields)
    load_attr(:model, value: model_name)
    load_attr(:display_name)
    load_attr(:minimum_input_length)
    load_attr(:url, default: url_from_method)
    load_attr(:response_root, default: tableize_method)
    load_parent_data_options
    load_collection_data
  end

  def load_parent_data_options
    return unless @options[:parent_attribute]
    load_attr(:parent, value: @options[:parent_attribute])
    load_attr(:parent_id, value: @object.send(@options[:parent_attribute]))
  end

  def load_collection_data
    return unless @options[:collection]

    collection_options = collection_to_select_options do |item, option|
      if !!@options[:parent_attribute]
        option[@options[:parent_attribute]] = item.send(@options[:parent_attribute])
      end
    end

    load_attr(:collection, value: collection_options)
  end
end
