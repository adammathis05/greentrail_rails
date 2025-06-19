FactoryBot.define do
  factory :event do
    event_name { Faker::Lorem.sentence(word_count: 3) }
    date { Faker::Date.forward(days: 60) }
    category { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    community
    site
  end
end