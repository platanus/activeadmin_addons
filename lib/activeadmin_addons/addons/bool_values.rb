module ActiveAdminAddons
  DEFAULT_BOOLEAN_TRUE = '&#x2714;'
  DEFAULT_BOOLEAN_FALSE = '&#x2717;'

  module BoolValues
    class << self
      def bool_value(model, attribute, &block)
        data = model.send(attribute)
        data = block.call(model) if block
        if data
          i18n_lookup(model, attribute, 'true_value', DEFAULT_BOOLEAN_TRUE)
        else
          i18n_lookup(model, attribute, 'false_value', DEFAULT_BOOLEAN_FALSE)
        end
      end

      private

      def i18n_lookup(model, attribute, key, last_default)
        model_name = model.class.model_name.i18n_key

        model_i18n = "activeadmin.addons.boolean.models.#{model_name}.#{key}"
        default_i18n = "activeadmin.addons.boolean.default.#{key}"

        I18n.t(model_i18n, default: I18n.t(default_i18n, default: last_default)).html_safe
      end
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def bool_column(*args, &block)
          attribute = args[1] || args[0]
          column(*args) { |model| BoolValues.bool_value(model, attribute, &block) }
        end
      end
      class AttributesTable
        def bool_row(*args, &block)
          attribute = args[1] || args[0]
          row(*args) { |model| BoolValues.bool_value(model, attribute, &block) }
        end
      end
    end
  end
end
