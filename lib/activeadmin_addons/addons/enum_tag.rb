module ActiveAdminAddons
  module EnumTag
    class << self
      def tag(context, model, attribute, &block)
        state = model.send(attribute)
        state = block.call(model) if block
        raise 'you need to install enumerize gem first' unless defined? Enumerize::Value
        raise 'you need to pass an enumerize attribute' unless state.is_a?('Enumerize::Value'.constantize)
        context.status_tag(state.text, state)
      end
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def tag_column(*args, &block)
          attribute = args[1] || args[0]
          column(*args) { |model| EnumTag.tag(self, model, attribute, &block) }
        end
      end
      class AttributesTable
        def tag_row(*args, &block)
          attribute = args[1] || args[0]
          row(*args) { |model| EnumTag.tag(self, model, attribute, &block) }
        end
      end
    end
  end
end
