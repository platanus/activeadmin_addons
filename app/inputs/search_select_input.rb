class SearchSelectInput < Formtastic::Inputs::StringInput
  def input_html_options
    relation = @object.send(attributized_method_name)
    opts = {}
    opts[:class] = ['select2-ajax'].concat([@options[:class]] || []).join(' ')
    opts["data-fields"] = (@options[:fields] || []).to_json
    opts["data-url"] = @options[:url] || ""
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1
    opts["data-selected"] = relation.try(opts["data-display_name"].to_sym)
    super.merge opts
  end
end
