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
      @options ||= args.last.is_a?(Hash) ? args.last : {}
    end

    def attribute
      @attribute ||= args[1] || args[0]
    end

  end
end
