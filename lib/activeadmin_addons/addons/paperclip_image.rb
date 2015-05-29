module ActiveAdminAddons
  class PaperclipImageBuilder < CustomBuilder
    def render
      return nil if data.nil?
      raise 'you need to pass a paperclip image attribute' unless data.respond_to?(:url)
      style = options.fetch(:style, :original)
      context.image_tag(data.url(style)) if data.exists?
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def image_column(*args, &block)
          column(*args) { |model| PaperclipImageBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def image_row(*args, &block)
          row(*args) { |model| PaperclipImageBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
