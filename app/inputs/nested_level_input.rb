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
    load_class(@options[:class])
    load_data_attr(:fields, default: ["name"], formatter: :to_json)
    load_data_attr(:predicate, default: "cont")
    load_data_attr(:filters)
    load_data_attr(:model, value: model_name)
    load_data_attr(:display_name, default: "name")
    load_data_attr(:minimum_input_length, default: 1)
    load_data_attr(:url, default: url_from_method)
    load_data_attr(:response_root, default: tableize_method)
    load_data_attr(:width, default: "80%")
    load_data_attr(:order,
      value: @options[:order_by],
      default: get_data_attr_value(:fields).first.to_s + "_desc")
    load_parent_data_options
    load_collection_data
  end

  def load_parent_data_options
    return unless @options[:parent_attribute]
    load_data_attr(:parent, value: @options[:parent_attribute])
    load_data_attr(:parent_id, value: @object.send(@options[:parent_attribute]), default: -1)
  end

  def load_collection_data
    return unless @options[:collection]

    collection_options = collection_to_select_options do |item, option|
      if !!@options[:parent_attribute]
        option[@options[:parent_attribute]] = item.send(@options[:parent_attribute])
      end
    end

    load_data_attr(:collection, value: collection_options, formatter: :to_json)
  end
end
