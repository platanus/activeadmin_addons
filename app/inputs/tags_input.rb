class TagsInput < Formtastic::Inputs::StringInput
  def input_html_options
    opts = {}
    opts[:class] = "select2-tags"
    opts["data-collection"] = (@options[:collection] || []).to_json
    super.merge opts
  end
end
