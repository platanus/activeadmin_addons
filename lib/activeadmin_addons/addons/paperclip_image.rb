module ActiveAdminAddons
  module PaperclipImage
    class << self
      def image(context, model, attribute, options)
        img = model.send(attribute)
        raise 'you need to pass a paperclip image attribute' unless img.respond_to?(:url)
        style = options.fetch(:style, :original)
        context.image_tag(img.url(style)) if img.exists?
      end
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def image_column(attribute, options = {})
          column(attribute) { |model| PaperclipImage.image(self, model, attribute, options) }
        end
      end
      class AttributesTable
        def image_row(attribute, options = {})
          row(attribute) { |model| PaperclipImage.image(self, model, attribute, options) }
        end
      end
    end
  end
end
