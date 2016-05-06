module ActiveAdminAddons
  class EnumBuilder < CustomBuilder
    def render
      @is_enum = false
      begin
        @is_enum = :enumerize if data.is_a?('Enumerize::Value'.constantize)
      rescue NameError
        # ignore if Enumerize is not defined
      end
      if defined? Rails && Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 1
        @is_enum = :enum if model.defined_enums[attribute.to_s]
      end
      raise 'you need to pass an enumerize or enum attribute' unless @is_enum
      context.status_tag(display_data, data)
    end

    def display_data
      @is_enum == :enumerize ? data.text : data
    end
  end

  module ::ActiveAdmin
    module Views
      class TableFor
        def tag_column(*args, &block)
          column(*args) { |model| EnumBuilder.render(self, model, *args, &block) }
        end
      end
      class AttributesTable
        def tag_row(*args, &block)
          row(*args) { |model| EnumBuilder.render(self, model, *args, &block) }
        end
      end
    end
  end
end
