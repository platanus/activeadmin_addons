ENV["RAILS_ENV"] ||= 'test'

require 'spec_helper'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'shoulda-matchers'

def reload_menus!
  ActiveAdmin.application.namespaces.each { |n| n.reset_menu! }
end

def reload_routes!
  Rails.application.reload_routes!
end

# Setup ActiveAdmin
ActiveAdmin.application.load_paths = [File.expand_path("../dummy/app/admin", __FILE__)]
ActiveAdmin.unload!
ActiveAdmin.load!
reload_menus!
reload_routes!

# Disabling authentication in specs so that we don't have to worry about
# it allover the place
ActiveAdmin.application.authentication_method = false
ActiveAdmin.application.current_user_method = false


ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.order = :random
  config.render_views
  config.include FactoryGirl::Syntax::Methods
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  FactoryGirl::SyntaxRunner.send(:include, RSpec::Mocks::ExampleMethods)
end
