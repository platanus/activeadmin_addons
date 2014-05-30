$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin_ui_addons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-ui-addons"
  s.version     = ActiveadminUiAddons::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActiveadminUiAddons."
  s.description = "TODO: Description of ActiveadminUiAddons."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.5"
  
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
