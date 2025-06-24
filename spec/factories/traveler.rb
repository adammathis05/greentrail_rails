FactoryBot.define do
  factory :traveler do
    first { Faker::Name.first_name }
    last  { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    password_confirmation { "password123" }
    role { :traveler }
  end
end