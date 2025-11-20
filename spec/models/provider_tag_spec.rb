require 'rails_helper'

RSpec.describe ProviderTag, type: :model do
  describe 'associations' do
    describe 'belongs_to provider' do
      it 'belongs to a provider' do
        provider = create(:provider)
        provider_tag = create(:provider_tag, provider: provider)

        expect(provider_tag.provider).to eq(provider)
      end

      it 'is invalid without a provider' do
        provider_tag = build(:provider_tag, provider: nil)
        expect(provider_tag).not_to be_valid
      end
    end

    describe 'belongs_to tag' do
      it 'belongs to a tag' do
        tag = create(:tag)
        provider_tag = create(:provider_tag, tag: tag)

        expect(provider_tag.tag).to eq(tag)
      end

      it 'is invalid without a tag' do
        provider_tag = build(:provider_tag, tag: nil)
        expect(provider_tag).not_to be_valid
      end
    end
  end

  describe 'validations' do
    describe 'provider_id presence' do
      it 'is invalid without a provider_id' do
        provider_tag = build(:provider_tag, provider: nil)
        expect(provider_tag).not_to be_valid
        expect(provider_tag.errors[:provider_id]).to include("can't be blank")
      end
    end

    describe 'tag_id presence' do
      it 'is invalid without a tag_id' do
        provider_tag = build(:provider_tag, tag: nil)
        expect(provider_tag).not_to be_valid
        expect(provider_tag.errors[:tag_id]).to include("can't be blank")
      end
    end

    describe 'tag_id uniqueness scoped to provider_id' do
      it 'is valid with a unique tag for a provider' do
        provider = create(:provider)
        tag1 = create(:tag)
        tag2 = create(:tag)

        provider_tag1 = create(:provider_tag, provider: provider, tag: tag1)
        provider_tag2 = build(:provider_tag, provider: provider, tag: tag2)

        expect(provider_tag2).to be_valid
      end

      it 'is invalid with a duplicate tag for the same provider' do
        provider = create(:provider)
        tag = create(:tag)

        create(:provider_tag, provider: provider, tag: tag)
        duplicate_provider_tag = build(:provider_tag, provider: provider, tag: tag)

        expect(duplicate_provider_tag).not_to be_valid
        expect(duplicate_provider_tag.errors[:tag_id]).to include("has already been added to this provider")
      end

      it 'is valid with the same tag for different providers' do
        provider1 = create(:provider)
        provider2 = create(:provider)
        tag = create(:tag)

        provider_tag1 = create(:provider_tag, provider: provider1, tag: tag)
        provider_tag2 = build(:provider_tag, provider: provider2, tag: tag)

        expect(provider_tag2).to be_valid
      end
    end
  end

  describe 'factory' do
    it 'creates a provider_tag with a provider' do
      provider_tag = create(:provider_tag)
      expect(provider_tag.provider).to be_present
      expect(provider_tag.provider).to be_a(Provider)
    end

    it 'creates a provider_tag with a tag' do
      provider_tag = create(:provider_tag)
      expect(provider_tag.tag).to be_present
      expect(provider_tag.tag).to be_a(Tag)
    end
  end

  describe 'database columns' do
    it 'has a provider_id foreign key' do
      provider_tag = create(:provider_tag)
      expect(provider_tag.provider_id).to be_present
    end

    it 'has a tag_id foreign key' do
      provider_tag = create(:provider_tag)
      expect(provider_tag.tag_id).to be_present
    end

    it 'has timestamps' do
      provider_tag = create(:provider_tag)
      expect(provider_tag.created_at).to be_present
      expect(provider_tag.updated_at).to be_present
    end
  end

  describe 'join table behavior' do
    it 'allows a provider to have multiple tags' do
      provider = create(:provider)
      tag1 = create(:tag)
      tag2 = create(:tag)
      tag3 = create(:tag)

      create(:provider_tag, provider: provider, tag: tag1)
      create(:provider_tag, provider: provider, tag: tag2)
      create(:provider_tag, provider: provider, tag: tag3)

      expect(provider.tags.count).to eq(3)
      expect(provider.tags).to contain_exactly(tag1, tag2, tag3)
    end

    it 'allows a tag to be used by multiple providers' do
      tag = create(:tag)
      provider1 = create(:provider)
      provider2 = create(:provider)
      provider3 = create(:provider)

      create(:provider_tag, provider: provider1, tag: tag)
      create(:provider_tag, provider: provider2, tag: tag)
      create(:provider_tag, provider: provider3, tag: tag)

      expect(tag.providers.count).to eq(3)
      expect(tag.providers).to contain_exactly(provider1, provider2, provider3)
    end
  end
end
