module ActiveAdminAddons
  class NumberBuilder < CustomBuilder
    NUMBER_TYPES = {
      currency: :number_to_currency,
      human: :number_to_human,
      human_size: :number_to_human_size,
      percentage: :number_to_percentage,
      phone: :number_to_phone,
      delimiter: :number_with_delimiter,
      precision: :number_with_precision
    }

    def render
      options[:as] = options.fetch(:as, :delimiter)
      if !NUMBER_TYPES.keys.include?(options[:as])
        raise "Invalid number type. Options are: #{NUMBER_TYPES.keys}"
      end
      context.send(NUMBER_TYPES[options[:as]], data, options)
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def number_column(*args, &block)
          column(*args) { |model| NumberBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def number_row(*args, &block)
          row(*args) { |model| NumberBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
