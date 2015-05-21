module ActiveAdminAddons
  module ListHelper
    class << self
      def localized_value(key, model, attribute)
         I18n.t("addons_list.#{model.class.name.underscore}.#{attribute}.#{key}")
      end

      def array_list(ctx, model, attribute, options)
        items = model.send(attribute)
        ctx.content_tag(options[:list_type]) do
          items.each do |value|
            value = localized_value(value, model, attribute) if !!options[:localize]
            ctx.concat(ctx.content_tag(:li, value))
          end
        end
      end

      def hash_list(ctx,  model, attribute, options)
        items = model.send(attribute)
        ctx.content_tag(options[:list_type]) do
          items.keys.each do |key|
            label =  !!options[:localize] ? localized_value(key, model, attribute) : key
            value = items[key]
            ctx.concat(ctx.content_tag(:li) do
              if value.blank?
                ctx.content_tag(:span, label)
              else
                ctx.content_tag(:span) do
                  ctx.concat("#{label}:&nbsp".html_safe)
                  ctx.concat(ctx.content_tag(:span) do
                    ctx.content_tag(:i, value)
                  end)
                end
              end
            end)
          end
        end
      end

      def list(ctx, model, attribute, options)
        options[:localize] = options.fetch(:localize, false)
        options[:list_type] = options.fetch(:list_type, :ul)
        raise 'invalid list type (ul, ol)' unless [:ul, :ol].include?(options[:list_type])

        items = model.send(attribute)

        if !items.is_a?(Hash) && !items.is_a?(Array)
          rails "list must be Array or Hash"
        end

        return array_list(ctx, model, attribute, options) if items.is_a?(Array)
        hash_list(ctx, model, attribute, options)
      end
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def list_column(attribute, options = {})
          column(attribute) { |model| ListHelper.list(self, model, attribute, options) }
        end
      end
      class AttributesTable
        def list_row(attribute, options = {})
          row(attribute) { |model| ListHelper.list(self, model, attribute, options) }
        end
      end
    end
  end
end
