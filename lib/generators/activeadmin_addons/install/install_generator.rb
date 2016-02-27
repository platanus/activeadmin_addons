module ActiveadminAddons
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def add_javascripts
        file_path = 'app/assets/javascripts/active_admin.js.coffee'
        line_to_add = "#= require activeadmin_addons/all\n"
        reference = "#= require active_admin/base\n"
        inject_into_file(file_path, line_to_add, after: reference)
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
