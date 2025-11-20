require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe 'associations' do
    describe 'belongs_to community' do
      it 'belongs to a community' do
        community = create(:community)
        provider = create(:provider, community: community)

        expect(provider.community).to eq(community)
      end

      it 'is invalid without a community' do
        provider = build(:provider, community: nil)
        expect(provider).not_to be_valid
      end
    end

    describe 'belongs_to site' do
      it 'belongs to a site' do
        site = create(:site)
        provider = create(:provider, site: site)

        expect(provider.site).to eq(site)
      end

      it 'is valid without a site (optional)' do
        provider = build(:provider, site: nil)
        expect(provider).to be_valid
      end
    end

    describe 'has_many provider_tags' do
      it 'has many provider_tags' do
        provider = create(:provider)
        expect(provider).to respond_to(:provider_tags)
        expect(provider.provider_tags).to eq([])
      end

      it 'can have multiple provider_tags' do
        provider = create(:provider)
        tag1 = create(:tag)
        tag2 = create(:tag)
        provider_tag1 = create(:provider_tag, provider: provider, tag: tag1)
        provider_tag2 = create(:provider_tag, provider: provider, tag: tag2)

        expect(provider.provider_tags).to contain_exactly(provider_tag1, provider_tag2)
      end

      it 'destroys dependent provider_tags when destroyed' do
        provider = create(:provider)
        tag1 = create(:tag)
        tag2 = create(:tag)
        create(:provider_tag, provider: provider, tag: tag1)
        create(:provider_tag, provider: provider, tag: tag2)

        expect { provider.destroy }.to change(ProviderTag, :count).by(-2)
      end
    end

    describe 'has_many tags' do
      it 'has many tags through provider_tags' do
        provider = create(:provider)
        expect(provider).to respond_to(:tags)
        expect(provider.tags).to eq([])
      end

      it 'can access tags through provider_tags' do
        provider = create(:provider)
        tag1 = create(:tag)
        tag2 = create(:tag)
        create(:provider_tag, provider: provider, tag: tag1)
        create(:provider_tag, provider: provider, tag: tag2)

        expect(provider.tags).to contain_exactly(tag1, tag2)
      end
    end
  end

  describe 'validations' do
    describe 'provider_name presence' do
      it 'is valid with a provider_name' do
        provider = build(:provider, provider_name: 'Test Provider')
        expect(provider).to be_valid
      end

      it 'is invalid without a provider_name' do
        provider = build(:provider, provider_name: nil)
        expect(provider).not_to be_valid
        expect(provider.errors[:provider_name]).to include("can't be blank")
      end

      it 'is invalid with an empty provider_name' do
        provider = build(:provider, provider_name: '')
        expect(provider).not_to be_valid
        expect(provider.errors[:provider_name]).to include("can't be blank")
      end
    end

    describe 'service presence' do
      it 'is valid with a service' do
        provider = build(:provider, service: 'Restaurant')
        expect(provider).to be_valid
      end

      it 'is invalid without a service' do
        provider = build(:provider, service: nil)
        expect(provider).not_to be_valid
        expect(provider.errors[:service]).to include("can't be blank")
      end

      it 'is invalid with an empty service' do
        provider = build(:provider, service: '')
        expect(provider).not_to be_valid
        expect(provider.errors[:service]).to include("can't be blank")
      end
    end

    describe 'description presence' do
      it 'is valid with a description' do
        provider = build(:provider, description: 'A great place')
        expect(provider).to be_valid
      end

      it 'is invalid without a description' do
        provider = build(:provider, description: nil)
        expect(provider).not_to be_valid
        expect(provider.errors[:description]).to include("can't be blank")
      end

      it 'is invalid with an empty description' do
        provider = build(:provider, description: '')
        expect(provider).not_to be_valid
        expect(provider.errors[:description]).to include("can't be blank")
      end
    end

    describe 'category presence' do
      it 'is valid with a category' do
        provider = build(:provider, category: 'explore')
        expect(provider).to be_valid
      end

      it 'is invalid without a category' do
        provider = build(:provider, category: nil)
        expect(provider).not_to be_valid
        expect(provider.errors[:category]).to include("can't be blank")
      end
    end
  end

  describe 'alias attributes' do
    it 'aliases name as provider_name' do
      provider = create(:provider, name: 'Test Provider')
      expect(provider.provider_name).to eq('Test Provider')
    end

    it 'can set provider_name using the alias' do
      provider = create(:provider)
      provider.provider_name = 'Updated Provider'
      expect(provider.name).to eq('Updated Provider')
    end
  end

  describe 'enums' do
    describe 'category enum' do
      it 'defines category enum values' do
        expect(described_class.categories).to eq({
          'explore' => 'Explore',
          'eat' => 'Eat',
          'stay' => 'Stay',
          'events' => 'Events',
          'amenities' => 'Amenities'
        })
      end

      it 'can set category to explore' do
        provider = create(:provider, category: 'explore')
        expect(provider.category).to eq('explore')
        expect(provider.explore?).to be true
      end

      it 'can set category to eat' do
        provider = create(:provider, category: 'eat')
        expect(provider.category).to eq('eat')
        expect(provider.eat?).to be true
      end

      it 'can set category to stay' do
        provider = create(:provider, category: 'stay')
        expect(provider.category).to eq('stay')
        expect(provider.stay?).to be true
      end

      it 'can set category to events' do
        provider = create(:provider, category: 'events')
        expect(provider.category).to eq('events')
        expect(provider.events?).to be true
      end

      it 'can set category to amenities' do
        provider = create(:provider, category: 'amenities')
        expect(provider.category).to eq('amenities')
        expect(provider.amenities?).to be true
      end

      it 'provides query methods for each category' do
        explore_provider = create(:provider, category: 'explore')
        eat_provider = create(:provider, category: 'eat')

        expect(explore_provider.explore?).to be true
        expect(explore_provider.eat?).to be false

        expect(eat_provider.eat?).to be true
        expect(eat_provider.explore?).to be false
      end
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      provider = build(:provider)
      expect(provider).to be_valid
    end

    it 'creates a provider with a name' do
      provider = create(:provider)
      expect(provider.name).to be_present
    end

    it 'creates a provider with a service' do
      provider = create(:provider)
      expect(provider.service).to be_present
    end

    it 'creates a provider with a description' do
      provider = create(:provider)
      expect(provider.description).to be_present
    end

    it 'creates a provider with a category' do
      provider = create(:provider)
      expect(provider.category).to be_present
    end

    it 'creates a provider with a community' do
      provider = create(:provider)
      expect(provider.community).to be_present
      expect(provider.community).to be_a(Community)
    end

    it 'creates a provider with a site' do
      provider = create(:provider)
      expect(provider.site).to be_present
      expect(provider.site).to be_a(Site)
    end
  end

  describe 'database columns' do
    it 'has a name column' do
      provider = create(:provider, name: 'Test Provider')
      expect(provider.name).to eq('Test Provider')
    end

    it 'has a service column' do
      provider = create(:provider, service: 'Restaurant')
      expect(provider.service).to eq('Restaurant')
    end

    it 'has a description column' do
      provider = create(:provider, description: 'Great food')
      expect(provider.description).to eq('Great food')
    end

    it 'has a category column' do
      provider = create(:provider, category: 'eat')
      expect(provider.category).to eq('eat')
    end

    it 'has a map_link column' do
      provider = create(:provider, map_link: 'https://maps.example.com')
      expect(provider.map_link).to eq('https://maps.example.com')
    end

    it 'has a site_id foreign key' do
      provider = create(:provider)
      expect(provider.site_id).to be_present
    end

    it 'has a community_id foreign key' do
      provider = create(:provider)
      expect(provider.community_id).to be_present
    end

    it 'has timestamps' do
      provider = create(:provider)
      expect(provider.created_at).to be_present
      expect(provider.updated_at).to be_present
    end
  end
end
