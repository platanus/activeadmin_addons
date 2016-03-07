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

      scope = "activeadmin.addons.boolean"
      value = I18n.t("models.#{model_name}.#{attribute}.#{key}", default: '', scope: scope)
      value = I18n.t("models.#{model_name}.#{key}", default: '', scope: scope) if value.empty?
      value = I18n.t("default.#{key}", default: last_default, scope: scope) if value.empty?

      value.html_safe
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
