# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :city do
    name { "MyString" }
    region { nil }
  end
end
