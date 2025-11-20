require 'rails_helper'

RSpec.describe Town, type: :model do
  describe 'inheritance' do
    it 'inherits from Location' do
      expect(Town.superclass).to eq(Location)
    end

    it 'sets type to Town' do
      town = create(:town)
      expect(town.type).to eq('Town')
    end
  end

  describe 'associations' do
    describe 'belongs_to province' do
      it 'belongs to a province' do
        province = create(:province)
        town = create(:town, province: province)

        expect(town.province).to eq(province)
      end

      it 'is invalid without a province' do
        town = build(:town, province: nil)
        expect(town).not_to be_valid
      end
    end

    describe 'has_many sites' do
      it 'has many sites' do
        town = create(:town)
        expect(town).to respond_to(:sites)
        expect(town.sites).to eq([])
      end

      it 'can have multiple sites' do
        town = create(:town)
        site1 = create(:site, town: town)
        site2 = create(:site, town: town)

        expect(town.sites).to contain_exactly(site1, site2)
      end

      it 'destroys dependent sites when destroyed' do
        town = create(:town)
        site1 = create(:site, town: town)
        site2 = create(:site, town: town)

        expect { town.destroy }.to change { Site.count }.by(-2)
      end
    end

    describe 'has_one community' do
      it 'has one community' do
        town = create(:town)
        expect(town).to respond_to(:community)
      end

      it 'can have a community associated' do
        town = create(:town)
        community = create(:community, town: town)

        expect(town.community).to eq(community)
      end

      it 'destroys dependent community when destroyed' do
        town = create(:town)
        community = create(:community, town: town)

        expect { town.destroy }.to change { Community.count }.by(-1)
      end
    end
  end

  describe 'alias attributes' do
    it 'aliases name as town_name (from Town)' do
      town = create(:town, name: 'Springfield')
      expect(town.town_name).to eq('Springfield')
    end

    it 'aliases name as location_name (from Location)' do
      town = create(:town, name: 'Portland')
      expect(town.location_name).to eq('Portland')
    end

    it 'can set town_name using the alias' do
      town = create(:town)
      town.town_name = 'Seattle'
      expect(town.name).to eq('Seattle')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      town = build(:town)
      expect(town).to be_valid
    end

    it 'creates a town with a name' do
      town = create(:town)
      expect(town.name).to be_present
    end

    it 'creates a town with a province' do
      town = create(:town)
      expect(town.province).to be_present
      expect(town.province).to be_a(Province)
    end

    it 'creates unique town names' do
      town1 = create(:town)
      town2 = create(:town)
      expect(town1.name).not_to eq(town2.name)
    end
  end

  describe 'database columns' do
    it 'has a name column' do
      town = create(:town, name: 'Test Town')
      expect(town.name).to eq('Test Town')
    end

    it 'has a type column for STI' do
      town = create(:town)
      expect(town).to respond_to(:type)
    end

    it 'has a province_id foreign key' do
      town = create(:town)
      expect(town.province_id).to be_present
    end

    it 'has timestamps' do
      town = create(:town)
      expect(town.created_at).to be_present
      expect(town.updated_at).to be_present
    end
  end
end
