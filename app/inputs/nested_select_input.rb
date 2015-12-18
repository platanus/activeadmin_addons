class NestedSelectInput < Formtastic::Inputs::StringInput
  def input_html_options
    add_virtual_accessor unless @object.respond_to?(attributized_method_name)
    relation = @object.send(attributized_method_name)

    opts = {}
    opts["class"] = ['select2-ajax'].concat([@options[:class]] || []).join(' ')
    opts["data-fields"] = (@options[:fields] || []).to_json
    opts["data-url"] = build_url
    opts["data-parent"] = @options[:parent]
    opts["data-model"] = @object.class.to_s.downcase
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1
    opts["data-selected"] = relation.try(opts["data-display_name"].to_sym)
    super.merge(opts)
  end

  private

  def add_virtual_accessor
    @object.singleton_class.send(:attr_accessor, attributized_method_name)
  end

  def build_url
    url = ["/"]

    if ActiveAdmin.application.default_namespace.present?
      url << "#{ActiveAdmin.application.default_namespace}/"
    end

    url << attributized_method_name.to_s.humanize.tableize

    url.join("")
  end
end
