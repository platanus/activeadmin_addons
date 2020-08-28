module ActiveadminAddons
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def create_initializer
        template "initializer.rb", "config/initializers/activeadmin_addons.rb"
      end

      def setup_assets
        if ActiveAdmin.application.use_webpacker
          generate "activeadmin_addons:webpacker"
        else
          generate "activeadmin_addons:assets"
        end
      end
    end
  end
end
