ENV["RAILS_ENV"] ||= 'test'

require 'spec_helper'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'shoulda-matchers'
require 'enumerize'
require 'paperclip'
require 'dragonfly'
require 'capybara/poltergeist'
require 'database_cleaner'

# Uncomment to work with poltergeist instead of firefox
# Capybara.javascript_driver = :poltergeist

# ActiveAdmin.application.load_paths = [File.expand_path("../dummy/app/admin", __FILE__)]

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each { |f| require f }

# Setup Some Admin stuff for us to play with
include ActiveAdminHelpers

Paperclip.options[:log] = false

RSpec.configure do |config|
  config.use_instantiated_fixtures = false
  config.filter_run focus: true
  config.filter_run_excluding skip: true
  config.run_all_when_everything_filtered = true

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
