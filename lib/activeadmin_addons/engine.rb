module ActiveAdminAddons
  module Rails
    class Engine < ::Rails::Engine
      require 'select2-rails'
      require 'xdan-datetimepicker-rails'

      initializer "initialize addons" do |app|
        require_relative './support/custom_builder'
        require_relative './addons/bool_values'
        require_relative './addons/paperclip_image'
        require_relative './addons/paperclip_attachment'
        require_relative './addons/enum_tag'
        require_relative './addons/state_values'
        require_relative './addons/number'
        require_relative './addons/list'
        require_relative './support/enumerize_formtastic_support'
        require_relative './support/set_datepicker'
        app.config.assets.precompile += %w(select.scss)
      end
    end
  end
end
