require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'associations' do
    it 'has many provider_tags' do
      tag = create(:tag)
      expect(tag).to respond_to(:provider_tags)
      expect(tag.provider_tags).to eq([])
    end

    it 'has many providers through provider_tags' do
      tag = create(:tag)
      expect(tag).to respond_to(:providers)
      expect(tag.providers).to eq([])
    end

    it 'destroys dependent provider_tags when destroyed' do
      tag = create(:tag)
      provider_tag = create(:provider_tag, tag: tag)

      expect { tag.destroy }.to change { ProviderTag.count }.by(-1)
    end
  end

  describe 'validations' do
    describe 'name presence' do
      it 'is valid with a name' do
        tag = build(:tag, tag_name: 'Valid Tag')
        expect(tag).to be_valid
      end

      it 'is invalid without a name' do
        tag = build(:tag, tag_name: nil)
        expect(tag).not_to be_valid
        expect(tag.errors[:name]).to include("can't be blank")
      end
    end

    describe 'name uniqueness' do
      it 'is invalid with a duplicate name' do
        create(:tag, tag_name: 'Duplicate')
        duplicate_tag = build(:tag, tag_name: 'Duplicate')

        expect(duplicate_tag).not_to be_valid
        expect(duplicate_tag.errors[:name]).to include('has already been taken')
      end

      it 'is valid with a unique name' do
        create(:tag, tag_name: 'First')
        unique_tag = build(:tag, tag_name: 'Second')

        expect(unique_tag).to be_valid
      end
    end
  end

  describe 'alias attributes' do
    it 'aliases tag_name as name' do
      tag = create(:tag, tag_name: 'Test Tag')
      expect(tag.name).to eq('Test Tag')
    end

    it 'can set name using the alias' do
      tag = create(:tag)
      tag.name = 'Updated Tag'
      expect(tag.tag_name).to eq('Updated Tag')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      tag = build(:tag)
      expect(tag).to be_valid
    end

    it 'creates a tag with a unique name' do
      tag1 = create(:tag)
      tag2 = create(:tag)
      expect(tag1.name).not_to eq(tag2.name)
    end
  end
end
