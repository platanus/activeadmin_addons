module ActiveAdminUIAddons
  class Railtie < Rails::Railtie
    initializer "set boolean values addon" do
      require_relative './addons/bool_values'
    end
  end
end
