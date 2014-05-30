module ActiveAdminUIAddons
  # TODO: Extract together with the bool methods
  DEFAULT_BOOLEAN_TRUE = '&#x2714;'
  DEFAULT_BOOLEAN_FALSE = '&#x2717;'

  class Railtie < Rails::Railtie
    initializer "set boolean stuff" do

      ActiveSupport.on_load(:action_controller) do
        # TODO: Extract bool methods
        module ::ActiveAdmin
          module Views
            class TableFor
              def bool_column(attribute)
                column(attribute) do |model|
                  if model[attribute]
                    I18n.t('activeadmin.addons.boolean.true', default: ActiveAdminUIAddons::DEFAULT_BOOLEAN_TRUE).html_safe
                  else
                    I18n.t('activeadmin.addons.boolean.false', default: ActiveAdminUIAddons::DEFAULT_BOOLEAN_FALSE).html_safe
                  end
                end
              end
            end
            class AttributesTable
              def bool_row(attribute)
                row(attribute) do |model|
                  if model[attribute]
                    I18n.t('activeadmin.addons.boolean.true', default: ActiveAdminUIAddons::DEFAULT_BOOLEAN_TRUE).html_safe
                  else
                    I18n.t('activeadmin.addons.boolean.false', default: ActiveAdminUIAddons::DEFAULT_BOOLEAN_FALSE).html_safe
                  end
                end
              end
            end
          end
        end
      end

    end
  end
end
