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
      raise "you need to install AASM gem first" unless defined? AASM
      raise "the #{attribute} is not an AASM state" unless state_attribute?
      context.status_tag(model.aasm(machine_name).human_state, class: status_class_for_model)
    end

    private

    def state_attribute?
      model.class.respond_to?(:aasm) &&
        attribute.present? &&
        model.class.aasm(machine_name).attribute_name == attribute.to_sym
    end

    def status_class_for_model
      class_bindings[data.to_sym] || data
    end

    def machine_name
      @machine_name ||= options.fetch(:machine, :default)
    end

    def class_bindings
      @class_bindings ||= DEFAULT_CLASS_BINDINGS.merge(options[:states] || {})
    end
  end
end

ActiveAdminAddons::StateBuilder.create_view_methods
