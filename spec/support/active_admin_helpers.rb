module ActiveAdminHelpers
  extend self

  def reload_menus!
    ActiveAdmin.application.namespaces.each(&:reset_menu!)
  end

  def register_page(klass, reset_app = true, &block)
    load_resources(reset_app) do
      ActiveAdmin.register(klass) do
        instance_eval(&block)
      end
    end
  end

  def register_index(klass, reset_app = true, &block)
    load_resources(reset_app) do
      ActiveAdmin.register(klass) do
        index do
          instance_eval(&block)
        end
      end
    end
  end

  def register_show(klass, reset_app = true, &block)
    load_resources(reset_app) do
      ActiveAdmin.register(klass) do
        show do
          attributes_table do
            instance_eval(&block)
          end
        end
      end
    end
  end

  def register_form(klass, reset_app = true, &block)
    load_resources(reset_app) do
      ActiveAdmin.register(klass) do
        form do |f|
          f.inputs "Details" do
            instance_exec(f, &block)
          end
        end
      end
    end
  end

  # Sometimes we need to reload the routes within
  # the application to test them out
  def reload_routes!(_show_routes = false)
    Rails.application.reload_routes!
    return unless _show_routes

    Rails.application.routes.routes.each do |route|
      puts route.path.spec.to_s
    end
  end

  # Helper method to load resources and ensure that Active Admin is
  # setup with the new configurations.
  #
  # Eg:
  #   load_resources(reset_app) do
  #     ActiveAdmin.regiser(Post)
  #   end
  #
  def load_resources(reset_app = true)
    if !!reset_app
      ActiveAdmin.application = nil
      ActiveAdmin.setup {}
      # Disabling authentication in specs so that we don't have to worry about
      # it allover the place
      ActiveAdmin.application.authentication_method = false
      ActiveAdmin.application.current_user_method = false
      ActiveAdmin.application.use_webpacker = ENV["SPROCKETS"] != "true"
    end

    yield

    reload_menus!
    reload_routes!
  end
end
