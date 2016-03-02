class ListBuilder < ActiveAdminAddons::CustomBuilder
  def render
    options[:localize] = options.fetch(:localize, false)
    options[:list_type] = options.fetch(:list_type, :ul)

    return if data.nil?

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

  def localized_value(model, attribute)
    I18n.t("addons_list.#{model.class.name.underscore}.#{attribute}.#{@level.join('_')}")
  end

  def render_array(_data)
    context.content_tag(options[:list_type]) do
      _data.each do |value|
        @level.push(value)
        if list? value
          value = render_list(value)
        elsif !!options[:localize]
          value = localized_value(model, attribute)
        end
        @level.pop
        context.concat(context.content_tag(:li, value))
      end
    end
  end

  def render_hash(_data)
    context.content_tag(options[:list_type]) do
      _data.keys.each do |key|
        @level.push(key)
        label = !!options[:localize] ? localized_value(model, attribute) : key
        value = _data[key]
        value = render_list(value) if list? value
        @level.pop
        hash_to_html(value, label)
      end
    end
  end

  def hash_to_html(_value, _label)
    context.concat(context.content_tag(:li) do
      if _value.blank?
        context.content_tag(:span, _label)
      else
        context.content_tag(:span) do
          context.concat("#{_label}:&nbsp".html_safe)
          context.concat(context.content_tag(:span) do
            context.content_tag(:i, _value)
          end)
        end
      end
    end)
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
