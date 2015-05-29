module ActiveAdminAddons
  class BoolBuilder < CustomBuilder
    DEFAULT_BOOLEAN_TRUE = '&#x2714;'
    DEFAULT_BOOLEAN_FALSE = '&#x2717;'

    def render
      if data
        i18n_lookup('true_value', DEFAULT_BOOLEAN_TRUE)
      else
        i18n_lookup('false_value', DEFAULT_BOOLEAN_FALSE)
      end
    end

    private

    def i18n_lookup(key, last_default)
      model_name = model.class.model_name.i18n_key

      model_i18n = "activeadmin.addons.boolean.models.#{model_name}.#{key}"
      default_i18n = "activeadmin.addons.boolean.default.#{key}"

      I18n.t(model_i18n, default: I18n.t(default_i18n, default: last_default)).html_safe
    end
  end

  module BoolValues

    module ::ActiveAdmin
      module Views
        class TableFor
          def bool_column(*args, &block)
            column(*args) { |model| BoolBuilder.render(self, model, *args, &block) }
          end
        end
        class AttributesTable
          def bool_row(*args, &block)
            row(*args) { |model| BoolBuilder.render(self, model, *args, &block) }
          end
        end
      end
    end
  end
end
