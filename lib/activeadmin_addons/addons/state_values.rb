module ActiveAdminAddons
  class StateBuilder < CustomBuilder
    DEFAULT_CLASS_BINDINGS = {
      accepted: "ok",
      confirmed: "ok",
      ready: "ok",
      rejected: "error",
      canceled: "error"
    }

    def render
      context.status_tag(model.state_name, status_class_for_model)
    end

    private

    def status_class_for_model
      class_bindings[data.to_sym] || data
    end

    def class_bindings
      @class_bindings ||= DEFAULT_CLASS_BINDINGS.merge(options[:states] || {})
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def state_column(*args, &block)
          column(*args) { |model| StateBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def state_row(*args, &block)
          row(*args) { |model| StateBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
