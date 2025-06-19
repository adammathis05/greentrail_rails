FactoryBot.define do
  factory :province, class: 'Province' do
    name { Faker::Address.state }
    type { 'Province' }
    country
  end
end