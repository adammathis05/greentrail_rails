require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'inheritance' do
    it 'inherits from Location' do
      expect(described_class.superclass).to eq(Location)
    end

    it 'sets type to Country' do
      country = create(:country)
      expect(country.type).to eq('Country')
    end
  end

  describe 'associations' do
    it 'has many provinces' do
      country = create(:country)
      expect(country).to respond_to(:provinces)
      expect(country.provinces).to eq([])
    end

    it 'can have multiple provinces' do
      country = create(:country)
      province1 = create(:province, country: country)
      province2 = create(:province, country: country)

      expect(country.provinces).to contain_exactly(province1, province2)
    end
  end

  describe 'alias attributes' do
    it 'aliases name as country_name (from Country)' do
      country = create(:country, name: 'Canada')
      expect(country.country_name).to eq('Canada')
    end

    it 'aliases name as location_name (from Location)' do
      country = create(:country, name: 'United States')
      expect(country.location_name).to eq('United States')
    end

    it 'can set country_name using the alias' do
      country = create(:country)
      country.country_name = 'Australia'
      expect(country.name).to eq('Australia')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      country = build(:country)
      expect(country).to be_valid
    end

    it 'creates a country with a name' do
      country = create(:country)
      expect(country.name).to be_present
    end

    it 'creates unique country names' do
      country1 = create(:country)
      country2 = create(:country)
      expect(country1.name).not_to eq(country2.name)
    end
  end

  describe 'database columns' do
    it 'has a name column' do
      country = create(:country, name: 'Test Country')
      expect(country.name).to eq('Test Country')
    end

    it 'has a type column for STI' do
      country = create(:country)
      expect(country).to respond_to(:type)
    end

    it 'has timestamps' do
      country = create(:country)
      expect(country.created_at).to be_present
      expect(country.updated_at).to be_present
    end
  end
end
