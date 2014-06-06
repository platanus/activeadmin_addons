module ActiveAdminUIAddons
  module Rails
    class Engine < ::Rails::Engine
      initializer "set boolean values addon" do
        require_relative './addons/bool_values'
      end
    end
  end
end
