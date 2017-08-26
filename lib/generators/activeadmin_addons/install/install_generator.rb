module ActiveadminAddons
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_initializer
        template "initializer.rb", "config/initializers/activeadmin_addons.rb"
      end

      def add_javascripts
        file_path = 'app/assets/javascripts/active_admin'
        line_to_add = "#= require activeadmin_addons/all\n"
        reference = "#= require active_admin/base\n"

        begin
          inject_into_file("#{file_path}.js.coffee", line_to_add, after: reference)
        rescue Errno::ENOENT
          line_to_add = "//= require activeadmin_addons/all\n"
          reference = "//= require active_admin/base\n"
          inject_into_file("#{file_path}.js", line_to_add, after: reference)
        end
      end

      def add_stylesheets
        file_path = 'app/assets/stylesheets/active_admin'
        line_to_add = "//= require activeadmin_addons/all\n"

        begin
          prepend_file("#{file_path}.scss", line_to_add)
        rescue Errno::ENOENT
          prepend_file("#{file_path}.css.scss", line_to_add)
        end
      end
    end
  end
end
