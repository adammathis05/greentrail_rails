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
require 'erb'

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

    community = Community.first || Community.create!(name: "Sample Community", town: Town.first)

    provider_categories = Provider.categories.keys

    provider_categories.each do |category|
      3.times do |i|
        Provider.create!(
          name: "#{category.titleize} Place #{i + 1}",
          description: "A great place to #{category.downcase}.",
          service: "General Service Info",
          category: category,
          map_link: "https://maps.google.com/?q=#{ERB::Util.url_encode("Sample #{category.titleize} Place #{i + 1}")}",
          community: community,
          site: site
        )
      end
    end

    puts "Seeded #{provider_categories.size * 3} providers for #{community.name}"
      

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