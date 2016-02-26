class ListBuilder < ActiveAdminAddons::CustomBuilder

  def render
    options[:localize] = options.fetch(:localize, false)
    options[:list_type] = options.fetch(:list_type, :ul)

    raise 'invalid list type (ul, ol)' unless [:ul, :ol].include?(options[:list_type])
    raise "list must be Array or Hash" if !data.is_a?(Hash) && !data.is_a?(Array)

    @level = []
    render_list(data)
  end

  def render_list(_data)
    _data.is_a?(Array) ? render_array(_data) : render_hash(_data)
  end

  def list?(_data)
    _data.is_a?(Array) || _data.is_a?(Hash)
  end

  def localized_value(key, model, attribute)
    I18n.t("addons_list.#{model.class.name.underscore}.#{attribute}.#{@level.join("_")}")
  end

  def render_array(_data)
    context.content_tag(options[:list_type]) do
      _data.each do |value|
        if list? value
          value = render_list(value)
        else
          value = localized_value(value, model, attribute) if !!options[:localize]
        end
        context.concat(context.content_tag(:li, value))
      end
    end
  end

  def render_hash(_data)
    context.content_tag(options[:list_type]) do
      _data.keys.each do |key|
        @level.push(key)
        label =  !!options[:localize] ? localized_value(key, model, attribute) : key
        value = _data[key]
        value = render_list(value) if list? value
        context.concat(context.content_tag(:li) do
          if value.blank?
            context.content_tag(:span, label)
          else
            context.content_tag(:span) do
              context.concat("#{label}:&nbsp".html_safe)
              context.concat(context.content_tag(:span) do
                context.content_tag(:i, value)
              end)
            end
          end
        end)
        @level.pop
      end
    end
  end

end

module ::ActiveAdmin
  module Views
    class TableFor
      def list_column(*args, &block)
        column(*args) { |model| ::ListBuilder.new(self, model, *args, &block).render }
      end
    end
    class AttributesTable
      def list_row(*args, &block)
        row(*args) { |model| ::ListBuilder.new(self, model, *args, &block).render }
      end
    end
  end
end
