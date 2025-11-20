require 'rails_helper'

RSpec.describe Site, type: :model do
  describe 'associations' do
    describe 'belongs_to town' do
      it 'belongs to a town' do
        town = create(:town)
        site = create(:site, town: town)

        expect(site.town).to eq(town)
      end

      it 'is invalid without a town' do
        site = build(:site, town: nil)
        expect(site).not_to be_valid
      end
    end

    describe 'belongs_to community' do
      it 'belongs to a community' do
        community = create(:community)
        site = create(:site, community: community)

        expect(site.community).to eq(community)
      end

      it 'is invalid without a community' do
        site = build(:site, community: nil)
        expect(site).not_to be_valid
      end
    end

    describe 'has_many providers' do
      it 'has many providers' do
        site = create(:site)
        expect(site).to respond_to(:providers)
        expect(site.providers).to eq([])
      end

      it 'can have multiple providers' do
        site = create(:site)
        provider1 = create(:provider, site: site)
        provider2 = create(:provider, site: site)

        expect(site.providers).to contain_exactly(provider1, provider2)
      end

      it 'destroys dependent providers when destroyed' do
        site = create(:site)
        provider1 = create(:provider, site: site)
        provider2 = create(:provider, site: site)

        expect { site.destroy }.to change { Provider.count }.by(-2)
      end
    end
  end

  describe 'validations' do
    describe 'site_name presence' do
      it 'is valid with a site_name' do
        site = build(:site, site_name: 'Test Site')
        expect(site).to be_valid
      end

      it 'is invalid without a site_name' do
        site = build(:site, site_name: nil)
        expect(site).not_to be_valid
        expect(site.errors[:site_name]).to include("can't be blank")
      end

      it 'is invalid with an empty site_name' do
        site = build(:site, site_name: '')
        expect(site).not_to be_valid
        expect(site.errors[:site_name]).to include("can't be blank")
      end
    end
  end

  describe 'alias attributes' do
    it 'aliases name as site_name' do
      site = create(:site, name: 'Central Park')
      expect(site.site_name).to eq('Central Park')
    end

    it 'can set site_name using the alias' do
      site = create(:site)
      site.site_name = 'Golden Gate Park'
      expect(site.name).to eq('Golden Gate Park')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      site = build(:site)
      expect(site).to be_valid
    end

    it 'creates a site with a name' do
      site = create(:site)
      expect(site.name).to be_present
    end

    it 'creates a site with a town' do
      site = create(:site)
      expect(site.town).to be_present
      expect(site.town).to be_a(Town)
    end

    it 'creates a site with a community' do
      site = create(:site)
      expect(site.community).to be_present
      expect(site.community).to be_a(Community)
    end

    it 'creates unique site names' do
      site1 = create(:site)
      site2 = create(:site)
      expect(site1.name).not_to eq(site2.name)
    end
  end

  describe 'database columns' do
    it 'has a name column' do
      site = create(:site, name: 'Test Site')
      expect(site.name).to eq('Test Site')
    end

    it 'has a category column' do
      site = create(:site, category: 'Park')
      expect(site.category).to eq('Park')
    end

    it 'has a description column' do
      site = create(:site, description: 'A beautiful park')
      expect(site.description).to eq('A beautiful park')
    end

    it 'has a street_address column' do
      site = create(:site, street_address: '123 Main St')
      expect(site.street_address).to eq('123 Main St')
    end

    it 'has latitude and longitude columns' do
      site = create(:site, latitude: 45.5231, longitude: -122.6765)
      expect(site.latitude).to eq(45.5231)
      expect(site.longitude).to eq(-122.6765)
    end

    it 'has a map_link column' do
      site = create(:site, map_link: 'https://maps.example.com')
      expect(site.map_link).to eq('https://maps.example.com')
    end

    it 'has a town_id foreign key' do
      site = create(:site)
      expect(site.town_id).to be_present
    end

    it 'has a community_id foreign key' do
      site = create(:site)
      expect(site.community_id).to be_present
    end

    it 'has timestamps' do
      site = create(:site)
      expect(site.created_at).to be_present
      expect(site.updated_at).to be_present
    end
  end
end
