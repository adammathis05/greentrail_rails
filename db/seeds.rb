# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'factory_bot_rails'

# Explicitly include FactoryBot methods
class Seed
  include FactoryBot::Syntax::Methods

  def self.run
    new.run
  end

  def run
    5.times do
      country = create(:country)
      province = create(:province, country: country)
      town = create(:town, province: province)

      community = create(:community, town: town)
      community.save!
      site = create(:site, town: town, community: community)

    categories = ["Explore", "Eat", "Stay", "Events", "Amenities"]
    3.times do
      Provider.create!(
      name: Faker::Company.name,
      description: Faker::Lorem.sentence,
      category: categories.sample,
      site: Site.order("RANDOM()").first,
      community: Community.order("RANDOM()").first,
      map_link: Faker::Internet.url,
      service: %w[Stay Eat Explore Events Amenities].sample
    )
    end

    event = create(:event, community: community, site: site)
    create(:event_series, event: event, community: community, site: site)
  end

    5.times do
      create(:traveler,
      email: Faker::Internet.unique.email,
      password: "password123",
      password_confirmation: "password123",
      role: :traveler
    )
    end
  end
end

Seed.run

Faker::UniqueGenerator.clear