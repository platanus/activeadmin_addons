module ActiveAdminAddons
  module SelectFilterInputExtension
    def collection_from_enum?
      klass.respond_to?(:defined_enums) && klass.defined_enums.has_key?(method.to_s)
    end

    def collection
      if !options[:collection] && collection_from_enum?
        EnumUtils.options_for_select(klass, method.to_s, use_db_value: true)
      else
        super
      end
    end
  end
end

::ActiveAdmin::Inputs::Filters::SelectInput.prepend ActiveAdminAddons::SelectFilterInputExtension
