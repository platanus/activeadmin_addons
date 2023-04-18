module ActiveAdminAddons
  class CustomBuilder
    attr_accessor :context, :model, :args, :block

    def initialize(context, model, *args, &block)
      @context = context
      @model = model
      @args = *args
      @block = block
    end

    def render
      raise NotImplementedError
    end

    def self.create_view_methods
      builder_class = self
      builder_name = builder_method_name

      ::ActiveAdmin::Views::TableFor.class_eval do
        define_method("#{builder_name}_column") do |*args, &block|
          column(*args) { |model| builder_class.new(self, model, *args, &block).render }
        end
      end

      ::ActiveAdmin::Views::AttributesTable.class_eval do
        define_method("#{builder_name}_row") do |*args, &block|
          row(*args) { |model| builder_class.new(self, model, *args, &block).render }
        end
      end
    end

    def self.builder_method_name
      name.underscore.to_s.split("/").last.chomp("_builder")
    end

    protected

    def resource_url
      admin_resource&.route_instance_path(model, {})
    end

    def enabled_controller_action?(action)
      admin_controller_actions.include?(action)
    end

    def admin_controller_actions
      (admin_controller&.action_methods&.to_a || []).map(&:to_sym)
    end

    def admin_controller
      context&.controller
    end

    def admin_resource
      context.active_admin_resource_for(model.class)
    end

    def data
      @data ||= block ? block.call(model) : model.send(attribute)
    end

    def options
      @options ||= has_opts? ? args.last : {}
    end

    def class_name
      model.model_name.param_key
    end

    # attachment_column :foto
    # attachment_column :foto, style: :hola
    # attachment_column "Mi Foto", :foto
    # attachment_column "Mi Foto", :foto, {}
    # attachment_column :foto do
    # end
    def attribute
      @attribute ||= has_label? ? args[1] : args[0]
    end

    def has_label?
      args.length == (has_opts? ? 3 : 2)
    end

    def has_opts?
      @has_opts ||= args.last.is_a?(Hash)
    end

    create_view_methods
  end
end
