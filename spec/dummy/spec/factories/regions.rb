# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :region do
    name { "MyString" }
    country { nil }
  end
end
