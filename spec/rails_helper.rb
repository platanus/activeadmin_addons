ENV["RAILS_ENV"] ||= 'test'

require 'spec_helper'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'factory_bot_rails'
require 'webdrivers'
require 'capybara/rspec'
require 'capybara/rails'
require 'selenium-webdriver'
require 'shoulda-matchers'
require 'database_cleaner'
require 'rspec/retry'
require 'pry'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_instantiated_fixtures = false
  config.filter_run focus: true
  config.filter_run_excluding skip: true
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = false
  config.verbose_retry = true
  config.display_try_failure_messages = true

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

  config.around :each, :js do |ex|
    ex.run_with_retry retry: 3
  end

  # Cache the download of chrome driver for 1 day
  Webdrivers.cache_time = 86_400

  # Allow override of default path to Chrome (we use this in Travis)
  Selenium::WebDriver::Chrome.path = ENV['CHROME_PATH'] if ENV['CHROME_PATH']

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.register_driver :headless_chrome do |app|
    args = ['no-sandbox', 'headless', 'disable-gpu', 'remote-debugging-port=9222']
    options = Selenium::WebDriver::Chrome::Options.new(args: args)
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  Capybara.javascript_driver = ENV.fetch('JS_DRIVER', :headless_chrome).to_sym

  config.include ActiveAdminHelpers
  config.include DataLoaders
  config.include CapybaraHelpers
end
