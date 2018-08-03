module ActiveAdminAddons
  module Rails
    class Engine < ::Rails::Engine
      require "select2-rails"
      require "sass"
      begin
        require 'sassc-rails'
      rescue LoadError
        begin
          require 'sass-rails'
        rescue LoadError
          raise "Couldn't find 'sass-rails' or 'sassc-rails' gems in your application."
        end
      end
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
