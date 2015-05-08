module ActiveAdminAddons
  module EnumTag
    class << self
      def tag(context, model, attribute, options)
        state = model.send(attribute)
        raise 'you need to install enumerize gem first' unless defined? Enumerize::Value
        raise 'you need to pass an enumerize attribute' unless state.is_a?('Enumerize::Value'.constantize)
        context.status_tag(state.text, state)
      end
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def tag_column(attribute, options = {})
          column(attribute) { |model| EnumTag.tag(self, model, attribute, options) }
        end
      end
      class AttributesTable
        def tag_row(attribute, options = {})
          row(attribute) { |model| EnumTag.tag(self, model, attribute, options) }
        end
      end
    end
  end
end
