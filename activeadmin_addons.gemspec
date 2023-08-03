$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require "activeadmin_addons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin_addons"
  s.version     = ActiveadminAddons::VERSION
  s.authors     = ["Platanus", "Julio García", "Emilio Blanco", "Leandro Segovia"]
  s.email       = ["rubygems@platan.us", "julioggonz@gmail.com", "emilioeduardob@gmail.com",
                   "ldlsegovia@gmail.com"]
  s.homepage    = "https://github.com/platanus/activeadmin_addons"
  s.summary     = "Set of addons to help with the activeadmin ui"
  s.description = "Set of addons to help with the activeadmin ui"
  s.license     = "MIT"
  s.required_ruby_version = '>= 2.7.0'

  s.files = Dir["{app,config,db,lib,vendor/assets}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "railties"
  s.add_dependency "redcarpet"
  s.add_dependency "require_all"
  s.add_dependency "xdan-datetimepicker-rails", "~> 2.5.1"

  s.add_development_dependency "aasm"
  s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "image_processing"
  s.add_development_dependency "matrix"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "puma"
  s.add_development_dependency "rails", "~> 6.1", ">= 6.1.4.4"
  s.add_development_dependency "rexml"
  s.add_development_dependency "rspec_junit_formatter"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec-retry"
  s.add_development_dependency "rubocop", "~> 1.50"
  s.add_development_dependency "rubocop-performance"
  s.add_development_dependency "rubocop-rails"
  s.add_development_dependency "rubocop-rspec", "~> 2.2"
  s.add_development_dependency "selenium-webdriver", '~> 4.10'
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "shrine", "~> 3.0"
  s.add_development_dependency "sqlite3"
end
