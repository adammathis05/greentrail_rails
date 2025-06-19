FactoryBot.define do
  factory :province do
    name { Faker::Address.state }
    country
  end
end