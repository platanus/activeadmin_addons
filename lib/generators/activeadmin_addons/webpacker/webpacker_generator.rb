module ActiveadminAddons
  module Generators
    class WebpackerGenerator < Rails::Generators::Base
      def add_javascripts
        file_path = 'app/javascript/packs/active_admin.js'
        reference = "import \"@activeadmin/activeadmin\";\n"

        inject_into_file(file_path, js_assets, after: reference)
      end

      def add_stylesheets
        file_path = 'app/javascript/stylesheets/active_admin.scss'

        begin
          prepend_file(file_path, css_assets)
        end
      end

      def install_package
        run "yarn add activeadmin_addons"
      end

      private

      def js_assets
        to_add = "import \"activeadmin_addons\"\n"
        to_add
      end

      def css_assets
        "@import 'activeadmin_addons/src/stylesheets/all';\n"
      end
    end
  end
end
