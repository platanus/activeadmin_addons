source "https://rubygems.org"

# Declare your gem's dependencies in activeadmin_ui_addons.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem "debugger"
gem "activeadmin"
gem "mimemagic", github: "mimemagicrb/mimemagic", ref: "01f92d86d15d85cfd0f20dabd025dcbd36a8a60f"

gem "sassc", require: ENV["SPROCKETS"] == "true"
gem "sassc-rails", require: ENV["SPROCKETS"] == "true"
gem "webpacker", "~> 5.0", require: ENV["SPROCKETS"] != "true"
