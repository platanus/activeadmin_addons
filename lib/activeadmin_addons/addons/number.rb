module ActiveAdminAddons
  module NumberHelper
    class << self
      NUMBER_TYPES = {
        currency: :number_to_currency,
        human: :number_to_human,
        human_size: :number_to_human_size,
        percentage: :number_to_percentage,
        phone: :number_to_phone,
        delimiter: :number_with_delimiter,
        precision: :number_with_precision
      }

      def label(context, model, attribute, options)
        options[:as] = options.fetch(:as, :delimiter)
        if !NUMBER_TYPES.keys.include?(options[:as])
          raise "Invalid number type. Options are: #{NUMBER_TYPES.keys.to_s}"
        end
        number = model.send(attribute)
        context.send(NUMBER_TYPES[options[:as]], number, options)
      end
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def number_column(attribute, options = {})
          column(attribute) { |model| NumberHelper.label(self, model, attribute, options) }
        end
      end
      class AttributesTable
        def number_row(attribute, options = {})
          row(attribute) { |model| NumberHelper.label(self, model, attribute, options) }
        end
      end
    end
  end
end
