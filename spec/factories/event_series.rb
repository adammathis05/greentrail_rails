FactoryBot.define do
  factory :event_series do
    name { Faker::Educator.course_name } 
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