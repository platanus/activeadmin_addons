class TagsInput < ActiveAdminAddons::SelectInputBase
  include ActiveAdminAddons::SelectHelpers

  def render_custom_input
    render_collection_tags
  end

  def load_control_attributes
    @options[:multiple] = true
    load_data_attr(:width)

    if active_record_select?
      load_data_attr(:relation, value: true)
      load_data_attr(:collection, value: collection_to_select_options, formatter: :to_json)
    else
      load_data_attr(:collection, value: array_to_select_options, formatter: :to_json)
    end
  end

  private

  def render_collection_tags
    concat(label_html)
    concat(builder.select(method, [], input_options, input_html_options))
  end
end
