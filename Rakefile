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

task :tests do
  system "rspec ./spec/lib"
end

task :sprockets_tests do
  system "export SPROCKETS=true; yarn build; rspec ./spec/features"
end

task :webpack_tests do
  system "export SPROCKETS=false; rspec ./spec/features"
end

task :all_tests do
  system "rake tests"
  system "rake sprockets_tests"
  system "rake webpack_tests"
end

Bundler::GemHelper.install_tasks
