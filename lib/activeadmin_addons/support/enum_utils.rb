module ActiveAdminAddons
  class EnumUtils
    def self.options_for_select(klass, enum_name, use_db_value: false)
      enum_options_hash = klass.defined_enums[enum_name]
      enum_options_hash.map do |enum_option_name, db_value|
        value = use_db_value ? db_value : enum_option_name
        [translate_enum_option(klass, enum_name, enum_option_name), value]
      end
    end

    def self.translate_enum_option(klass, enum_name, enum_option_name)
      return if enum_option_name.blank?

      klass_key = klass.model_name.i18n_key
      key = "activerecord.attributes.#{klass_key}.#{enum_name.pluralize}.#{enum_option_name}"
      I18n.t(key, default: enum_option_name)
    end
  end
end
