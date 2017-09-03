# rubocop:disable Metrics/LineLength
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin_addons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin_addons"
  s.version     = ActiveadminAddons::VERSION
  s.authors     = ["Platanus", "Julio García", "Emilio Blanco", "Leandro Segovia"]
  s.email       = ["rubygems@platan.us", "julioggonz@gmail.com", "emilioeduardob@gmail.com", "ldlsegovia@gmail.com"]
  s.homepage    = "https://github.com/platanus/activeadmin_addons"
  s.summary     = "Set of addons to help with the activeadmin ui"
  s.description = "Set of addons to help with the activeadmin ui"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "railties"
  s.add_dependency "select2-rails", "~> 4.0"
  s.add_dependency "xdan-datetimepicker-rails", "~> 2.5.1"
  s.add_dependency "require_all"

  s.add_development_dependency "rails", ">= 4"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "3.0.1"
  s.add_development_dependency "pry-rails", "0.3.2"
  s.add_development_dependency "factory_girl_rails", "4.4.0"
  s.add_development_dependency "shoulda-matchers", "2.6.1"
  s.add_development_dependency "guard", "~> 2.7.0"
  s.add_development_dependency "guard-rspec", "~> 4.3"
  s.add_development_dependency "capybara"
  s.add_development_dependency "enumerize", "~> 2.0"
  s.add_development_dependency "paperclip"
  s.add_development_dependency "aasm"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "database_cleaner"
end
