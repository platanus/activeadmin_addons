module ActiveAdminAddons
  class TagBuilder < CustomBuilder
    def render
      @enum_attr = if enumerize_attr?
                     :enumerize
                   elsif rails_enum_attr?
                     :enum
                   end

      raise "you need to pass an enumerize or enum attribute" unless @enum_attr
      context.status_tag(display_data, data)
    end

    def display_data
      @enum_attr == :enumerize ? data.text : data
    end

    def enumerize_attr?
      data.is_a?("Enumerize::Value".constantize)
    rescue NameError
      false
    end

    def rails_enum_attr?
      defined? Rails && Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 1 &&
        model.defined_enums[attribute.to_s]
    end
  end
end

ActiveAdminAddons::TagBuilder.create_view_methods
