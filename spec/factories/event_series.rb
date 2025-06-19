FactoryBot.define do
  factory :event_series do
    event_series_name { Faker::Lorem.sentence(word_count: 2) }
    date { Faker::Date.forward(days: 60) }
    day_of_week { %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].sample }
    time { Faker::Time.forward(days: 23, period: :morning) }
    category { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    event
    community
    site
  end
end