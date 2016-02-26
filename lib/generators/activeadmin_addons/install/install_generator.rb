module ActiveadminAddons
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        inject_into_file 'app/assets/javascripts/active_admin.js.coffee', "#= require activeadmin_addons/all\n", after:"#= require active_admin/base\n"
      end

      def add_stylesheets
        prepend_file 'app/assets/stylesheets/active_admin.css.scss', "//= require activeadmin_addons/all\n"
      end
    end
  end
end
