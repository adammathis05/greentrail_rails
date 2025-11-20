require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'inheritance' do
    it 'inherits from ApplicationRecord' do
      expect(described_class.superclass).to eq(ApplicationRecord)
    end

    it 'has subclasses for Country, Province, and Town' do
      expect(Country.superclass).to eq(described_class)
      expect(Province.superclass).to eq(described_class)
      expect(Town.superclass).to eq(described_class)
    end
  end

  describe 'alias attributes' do
    context 'using Country subclass' do
      it 'aliases name as location_name' do
        country = create(:country, name: 'Canada')
        expect(country.location_name).to eq('Canada')
      end

      it 'can set location_name using the alias' do
        country = create(:country)
        country.location_name = 'Mexico'
        expect(country.name).to eq('Mexico')
      end
    end

    context 'using Province subclass' do
      it 'aliases name as location_name' do
        province = create(:province, name: 'Ontario')
        expect(province.location_name).to eq('Ontario')
      end
    end

    context 'using Town subclass' do
      it 'aliases name as location_name' do
        town = create(:town, name: 'Portland')
        expect(town.location_name).to eq('Portland')
      end
    end
  end

  describe 'database columns' do
    it 'has a name column' do
      country = create(:country, name: 'Test Location')
      expect(country.name).to eq('Test Location')
    end

    it 'has a type column for STI' do
      country = create(:country)
      expect(country).to respond_to(:type)
      expect(country.type).to eq('Country')
    end

    it 'has a country_id foreign key column' do
      province = create(:province)
      expect(province).to respond_to(:country_id)
    end

    it 'has a province_id foreign key column' do
      town = create(:town)
      expect(town).to respond_to(:province_id)
    end

    it 'has timestamps' do
      country = create(:country)
      expect(country.created_at).to be_present
      expect(country.updated_at).to be_present
    end
  end

  describe 'STI behavior' do
    it 'can query all locations across types' do
      country = create(:country)
      province = create(:province)
      town = create(:town)

      locations = described_class.all
      expect(locations).to include(country, province, town)
    end

    it 'stores different types in the same table' do
      country = create(:country)
      province = create(:province)
      town = create(:town)

      expect(country.class.table_name).to eq('locations')
      expect(province.class.table_name).to eq('locations')
      expect(town.class.table_name).to eq('locations')
    end

    it 'returns correct type for each subclass' do
      country = create(:country)
      province = create(:province)
      town = create(:town)

      expect(described_class.find(country.id)).to be_a(Country)
      expect(described_class.find(province.id)).to be_a(Province)
      expect(described_class.find(town.id)).to be_a(Town)
    end
  end
end
