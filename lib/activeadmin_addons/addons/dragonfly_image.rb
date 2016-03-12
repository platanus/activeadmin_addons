module ActiveAdminAddons
  class DragonflyImageBuilder < CustomBuilder
    def render
      return nil if data.nil?
      raise 'you need to pass a dragonfly image attribute' unless data.respond_to?(:url)
      size = options.fetch(:size, '100x100')
      context.image_tag(data.thumb(size).url) if data.stored?
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def dragonfly_image_column(*args, &block)
          column(*args) { |model| DragonflyImageBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def dragonfly_image_row(*args, &block)
          row(*args) { |model| DragonflyImageBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
