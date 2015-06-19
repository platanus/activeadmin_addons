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
      has_opts? ? args.length == 3 : args.length == 2
    end

    def has_opts?
      @has_opts ||= args.last.is_a?(Hash)
    end

  end
end
