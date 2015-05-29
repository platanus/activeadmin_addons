module ActiveAdminAddons
  class EnumBuilder < CustomBuilder
    def render
      raise 'you need to install enumerize gem first' unless defined? Enumerize::Value
      raise 'you need to pass an enumerize attribute' unless data.is_a?('Enumerize::Value'.constantize)
      context.status_tag(data.text, data)
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def tag_column(*args, &block)
          column(*args) { |model| EnumBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def tag_row(*args, &block)
          row(*args) { |model| EnumBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
