module ActiveAdminUIAddons
  module Rails
    class Engine < ::Rails::Engine
      require 'select2-rails'
      initializer "set boolean values addon" do |app|
        require_relative './addons/bool_values'
        app.config.assets.precompile +=  %w(select.scss)
      end
    end
  end
end
