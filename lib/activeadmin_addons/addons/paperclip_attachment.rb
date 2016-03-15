module ActiveAdminAddons
  class PaperclipAttachmentBuilder < AttachmentBuilder
    def render
      return nil if data.nil?
      raise 'you need to pass a paperclip attribute' unless data.respond_to?(:url)
      options[:truncate] = options.fetch(:truncate, true)
      return nil unless data.exists?
      context.link_to(build_label(data.original_filename), data.url, target: "_blank", class: "attachment-link")
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def attachment_column(*args, &block)
          column(*args) { |model| PaperclipAttachmentBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def attachment_row(*args, &block)
          row(*args) { |model| PaperclipAttachmentBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
