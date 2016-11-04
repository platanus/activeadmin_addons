class AjaxFilterInput < Formtastic::Inputs::StringInput
  include ActiveAdmin::Inputs::Filters::Base

  def input_html_options
    opts = {}
    opts[:class] = ['select2-ajax'].concat([@options[:class]] || []).join(' ')
    opts["data-fields"] = (@options[:fields] || []).to_json
    opts["data-url"] = @options[:url] || ""
    opts["data-response_root"] = @options[:response_root] || @options[:url].to_s.split('/').last
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1
    opts["data-width"] = "100%"
    selected = @object.public_send(method)
    opts["data-selected"] = selected
    super.merge opts
  end
end
