ENV["RAILS_ENV"] ||= 'test'

require 'spec_helper'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'factory_bot_rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'selenium-webdriver'
require 'shoulda-matchers'
require 'enumerize'
require 'paperclip'
require 'database_cleaner'
require 'pry'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each { |f| require f }

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

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  # change to :chrome if you want to see the browser running.
  Capybara.javascript_driver = :headless_chrome

  config.include ActiveAdminHelpers
  config.include DataLoaders
  config.include CapybaraHelpers
end
