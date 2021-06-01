begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActiveadminAddons'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :prepare_assets do
  system "rm -rf spec/dummy/public/packs"
  system "rm -rf spec/dummy/public/packs-test"
  system "yarn install"
  system "yarn build"
  system "(cd spec/dummy && yarn install)"
end

task :tests do
  system "rspec ./spec/lib"
end

task :sprockets_tests do
  system "rake prepare_assets"
  system "export SPROCKETS=true; rspec ./spec/features"
end

task :webpack_tests do
  system "rake prepare_assets"
  system "export SPROCKETS=false; rspec ./spec/features"
end

task :all_tests do
  system "rake prepare_assets"
  system "rake tests"
  system "export SPROCKETS=true; rspec ./spec/features"
  system "export SPROCKETS=false; rspec ./spec/features"
end

Bundler::GemHelper.install_tasks
