module ActiveadminAddons
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def create_initializer
        template "initializer.rb", "config/initializers/activeadmin_addons.rb"
      end

      def setup_assets
        if use_webpacker?
          generate "activeadmin_addons:webpacker"
        else
          puts "ActiveAdmin Addons requires ActiveAdmin installed with webpacker. "\
          "Please run 'rails generate active_admin:install --webpacker' and then 'rails generate activeadmin_addons:install'"
        end
      end

      private

      def use_webpacker?
        ActiveAdmin.application.use_webpacker
      rescue NoMethodError
        false
      end
    end
  end
end
