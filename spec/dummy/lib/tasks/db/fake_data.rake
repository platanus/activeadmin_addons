Rake::Task['db:setup'].enhance do
  Rake::Task['db:fake_data:load'].invoke
end

namespace :db do
  namespace :fake_data do
    desc "Loads development's fake data."
    task load: :environment do
      require 'fake_data_loader.rb'
      FakeDataLoader.load_data
    end
  end
end
