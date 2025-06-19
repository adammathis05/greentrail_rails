FactoryBot.define do
  factory :town, class: 'Town' do
    name { Faker::Address.city }
    type { 'Town' }
    province
  end
end