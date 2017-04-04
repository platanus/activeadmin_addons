class SearchSelectInput < Formtastic::Inputs::SelectInput
  def input_html_options
    relation = !@object.nil? ? @object.send(attributized_method_name) : ''
    opts = {}
    opts[:class] = ['select2-ajax'].concat([@options[:class]] || []).join(' ')
    opts["data-fields"] = (@options[:fields] || []).to_json
    opts["data-url"] = @options[:url] || ""
    opts["data-response_root"] = @options[:response_root] || @options[:url].to_s.split('/').last
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1
    opts["data-width"] = @options[:width] if @options[:width]
    opts["data-selected"] = relation.try(opts["data-display_name"].to_sym)
    opts["data-order"] = @options[:order_by] if @options[:order_by]
    opts["data-per_page"] = @options[:per_page] if @options[:per_page]
    super.merge opts
  end

  def collection
    if !@object.nil?
        { get_selected_value => @object[method] }
    else
        { '': '' }
    end
  end

  def get_selected_value(display_name = @options[:display_name] || "name")
    filter_class = method.to_s.chomp("_id").classify.constantize rescue @object.klass
    filter_class.find(@object[method]).send(display_name) if !!@object[method]
  end
end
