module ActiveAdminAddons
  class DragonflyAttachmentBuilder < AttachmentBuilder
    def render
      return nil if data.nil?
      raise 'you need to pass a dragonfly attribute' unless data.respond_to?(:url)
      options[:truncate] = options.fetch(:truncate, true)
      return nil unless data.stored?
      context.link_to(build_label(data.name), data.url, target: "_blank", class: "attachment-link")
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def dragonfly_attachment_column(*args, &block)
          column(*args) { |model| DragonflyAttachmentBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def dragonfly_attachment_row(*args, &block)
          row(*args) { |model| DragonflyAttachmentBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
