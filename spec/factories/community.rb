FactoryBot.define do
  factory :community do
    community_name { Faker::Address.community }
    description { Faker::Lorem.paragraph }
    association :town
  end
end
