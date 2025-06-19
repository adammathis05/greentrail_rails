FactoryBot.define do
  factory :provider do
    provider_name { Faker::Company.name }
    service { Faker::Company.industry }
    description { Faker::Lorem.paragraph }
    site
    community
  end
end