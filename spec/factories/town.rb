FactoryBot.define do
  factory :town do
    name { Faker::Address.city }
    province
  end
end