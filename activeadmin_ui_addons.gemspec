$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin_ui_addons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-ui-addons"
  s.version     = ActiveadminUiAddons::VERSION
  s.authors     = ["Platanus"]
  s.email       = ["contact@platan.us"]
  s.homepage    = "https://github.com/platanus/activeadmin-ui-addons"
  s.summary     = "Set of addons to help with the activeadmin ui"
  s.description = "Set of addons to help with the activeadmin ui"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4"
  s.add_dependency "railties"
  
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
