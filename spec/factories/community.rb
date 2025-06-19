FactoryBot.define do
  factory :community do
    community_name { Faker::Team.name }
    description { Faker::Lorem.paragraph }
    town
  end
end