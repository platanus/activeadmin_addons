module ActiveAdminAddons
  module RansackFormBuilderExtension
    def input(method, options = {})
      if object.is_a?(::Ransack::Search)
        klass = object.klass

        if klass.respond_to?(:enumerized_attributes) && (attr = klass.enumerized_attributes[method])
          options[:collection] ||= attr.options
          options[:as] = :select
        end
      end

      super(method, options)
    end
  end
end

::Formtastic::FormBuilder.send :prepend, ActiveAdminAddons::RansackFormBuilderExtension
