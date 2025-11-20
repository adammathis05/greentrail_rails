FactoryBot.define do
  factory :site do
    site_name { Faker::Company.name }
    category { Faker::Commerce.department }
    description { Faker::Lorem.sentence }
    street_address { Faker::Address.street_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    map_link { Faker::Internet.url }
    town
    community
  end
end
