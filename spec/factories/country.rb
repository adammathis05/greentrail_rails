FactoryBot.define do
  factory :country, class: 'Country' do
    name { Faker::Address.country }
    type { 'Country' }
  end
end
