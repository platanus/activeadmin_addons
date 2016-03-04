module ActiveAdminAddons
  module RansackFormBuilderExtension
    extend ActiveSupport::Concern

    included do
      alias_method_chain :input, :ransack
    end

    def input_with_ransack(method, options = {})
      if object.is_a?(::Ransack::Search)
        klass = object.klass

        if klass.respond_to?(:enumerized_attributes) && (attr = klass.enumerized_attributes[method])
          options[:collection] ||= attr.options
          options[:as] = :select
        end
      end

      input_without_ransack(method, options)
    end
  end
end

::Formtastic::FormBuilder.send :include, ActiveAdminAddons::RansackFormBuilderExtension
