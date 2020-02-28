module ActiveAdminAddons
  module Rails
    class Engine < ::Rails::Engine
      require 'sassc'
      require 'sassc-rails'
      require "xdan-datetimepicker-rails"
      require "require_all"
      require "active_material"

      initializer "initialize addons" do |app|
        require_rel "support"
        require_rel "addons"
        require_rel "active_admin_config"
        app.config.assets.precompile += %w(select.scss fileicons/*.png switches/switch_*.png
                                           material/icons *.svg)
      end
    end
  end
end
