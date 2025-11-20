require 'rails_helper'

RSpec.describe Province, type: :model do
  describe 'inheritance' do
    it 'inherits from Location' do
      expect(Province.superclass).to eq(Location)
    end

    it 'sets type to Province' do
      province = create(:province)
      expect(province.type).to eq('Province')
    end
  end

  describe 'associations' do
    describe 'belongs_to country' do
      it 'belongs to a country' do
        country = create(:country)
        province = create(:province, country: country)

        expect(province.country).to eq(country)
      end

      it 'is invalid without a country' do
        province = build(:province, country: nil)
        expect(province).not_to be_valid
      end
    end

    describe 'has_many towns' do
      it 'has many towns' do
        province = create(:province)
        expect(province).to respond_to(:towns)
        expect(province.towns).to eq([])
      end

      it 'can have multiple towns' do
        province = create(:province)
        town1 = create(:town, province: province)
        town2 = create(:town, province: province)

        expect(province.towns).to contain_exactly(town1, town2)
      end
    end
  end

  describe 'alias attributes' do
    it 'aliases name as location_name (from Location)' do
      province = create(:province, name: 'Ontario')
      expect(province.location_name).to eq('Ontario')
    end

    it 'can set location_name using the alias' do
      province = create(:province)
      province.location_name = 'British Columbia'
      expect(province.name).to eq('British Columbia')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      province = build(:province)
      expect(province).to be_valid
    end

    it 'creates a province with a name' do
      province = create(:province)
      expect(province.name).to be_present
    end

    it 'creates a province with a country' do
      province = create(:province)
      expect(province.country).to be_present
      expect(province.country).to be_a(Country)
    end

    it 'creates unique province names' do
      province1 = create(:province)
      province2 = create(:province)
      expect(province1.name).not_to eq(province2.name)
    end
  end

  describe 'database columns' do
    it 'has a name column' do
      province = create(:province, name: 'Test Province')
      expect(province.name).to eq('Test Province')
    end

    it 'has a type column for STI' do
      province = create(:province)
      expect(province).to respond_to(:type)
    end

    it 'has a country_id foreign key' do
      province = create(:province)
      expect(province.country_id).to be_present
    end

    it 'has timestamps' do
      province = create(:province)
      expect(province.created_at).to be_present
      expect(province.updated_at).to be_present
    end
  end
end
