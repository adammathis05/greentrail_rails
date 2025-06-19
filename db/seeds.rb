# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'factory_bot'
require 'faker'
include FactoryBot::Syntax::Methods
FactoryBot.find_definitions

5.times do
  country = create(:country)
  province = create(:province, country: country)
  town = create(:town, province: province)
  community = create(:community, town: town)
  site = create(:site, town: town, community: community)

  3.times do
    provider = create(:provider, site: site, community: community)
    tag = create(:tag)
    create(:provider_tag, provider: provider, tag: tag)
  end

  event = create(:event, community: community, site: site)
  create(:event_series, event: event, community: community, site: site)
end

5.times do
  create(:traveler)
end

