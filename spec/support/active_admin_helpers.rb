module ActiveAdminHelpers
  extend self

  def reload_menus!
    ActiveAdmin.application.namespaces.each(&:reset_menu!)
  end

  def register_index(klass, &block)
    load_resources do
      ActiveAdmin.register(klass) do
        index do
          instance_eval(&block)
        end
      end
    end
  end

  def register_show(klass, &block)
    load_resources do
      ActiveAdmin.register(klass) do
        show do
          attributes_table do
            instance_eval(&block)
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
  #   load_resources do
  #     ActiveAdmin.regiser(Post)
  #   end
  #
  def load_resources
    ActiveAdmin.application = ::ActiveAdmin::Application.new
    yield
    reload_menus!
    reload_routes!
  end
end
