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
    end

    def self.render(context, model, *args, &block)
      new(context, model, *args, &block).render
    end

    protected

    def data
      @data ||= block ? block.call(model) : model.send(attribute)
    end

    def options
      @options ||= has_opts? ? args.last : {}
    end

    def attribute
      @attribute ||= has_opts? ? args[0] : args[1]
    end

    def has_opts?
      args[1] && args[1].is_a?(Hash)
    end

  end
end
