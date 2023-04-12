module ActiveAdminAddons
  module Rails
    class Engine < ::Rails::Engine
      require "xdan-datetimepicker-rails"
      require "require_all"

      initializer "initialize addons" do |_app|
        require_rel "support"
        require_rel "addons"
        require_rel "active_admin_config"
      end
    end
  end
end
