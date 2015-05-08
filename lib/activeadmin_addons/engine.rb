module ActiveAdminAddons
  module Rails
    class Engine < ::Rails::Engine
      require 'select2-rails'
      initializer "set boolean values addon" do |app|
        require_relative './set_datepicker'
        require_relative './addons/bool_values'
        require_relative './addons/paperclip_image'
        require_relative './addons/enum_tag'
        app.config.assets.precompile +=  %w(select.scss)
      end
    end
  end
end
