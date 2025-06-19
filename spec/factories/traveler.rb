FactoryBot.define do
  factory :traveler do
    first { Faker::Name.first_name }
    last { Faker::Name.last_name }
    email { Faker::Internet.email }
  end
end