require 'rails_helper'

RSpec.describe Community, type: :model do
  describe 'associations' do
    describe 'belongs_to town' do
      it 'belongs to a town' do
        town = create(:town)
        community = create(:community, town: town)

        expect(community.town).to eq(town)
      end

      it 'is invalid without a town' do
        community = build(:community, town: nil)
        expect(community).not_to be_valid
      end
    end

    describe 'belongs_to community_center_site' do
      it 'can belong to a community_center_site' do
        site = create(:site)
        community = create(:community, community_center_site: site)

        expect(community.community_center_site).to eq(site)
      end

      it 'is valid without a community_center_site (optional)' do
        community = build(:community, community_center_site: nil)
        expect(community).to be_valid
      end
    end

    describe 'has_many sites through town' do
      it 'has many sites through town' do
        community = create(:community)
        expect(community).to respond_to(:sites)
      end

      it 'can access sites from its town' do
        town = create(:town)
        community = create(:community, town: town)
        site1 = create(:site, town: town, community: community)
        site2 = create(:site, town: town, community: community)

        expect(community.sites).to include(site1, site2)
      end
    end

    describe 'has_many providers' do
      it 'has many providers' do
        community = create(:community)
        expect(community).to respond_to(:providers)
        expect(community.providers).to eq([])
      end

      it 'can have multiple providers' do
        community = create(:community)
        provider1 = create(:provider, community: community)
        provider2 = create(:provider, community: community)

        expect(community.providers).to contain_exactly(provider1, provider2)
      end

      it 'destroys dependent providers when destroyed' do
        community = create(:community)
        provider1 = create(:provider, community: community)
        provider2 = create(:provider, community: community)

        expect { community.destroy }.to change(Provider, :count).by(-2)
      end
    end

    describe 'has_many events' do
      it 'has many events' do
        community = create(:community)
        expect(community).to respond_to(:events)
        expect(community.events).to eq([])
      end

      it 'destroys dependent events when destroyed' do
        community = create(:community)
        event1 = create(:event, community: community)
        event2 = create(:event, community: community)

        expect { community.destroy }.to change(Event, :count).by(-2)
      end
    end

    describe 'has_many saved_communities' do
      it 'has many saved_communities' do
        community = create(:community)
        expect(community).to respond_to(:saved_communities)
        expect(community.saved_communities).to eq([])
      end

      it 'destroys dependent saved_communities when destroyed' do
        community = create(:community)
        traveler = create(:traveler)
        saved_community = create(:saved_community, community: community, traveler: traveler)

        expect { community.destroy }.to change(SavedCommunity, :count).by(-1)
      end
    end

    describe 'has_many saved_by_travelers' do
      it 'has many saved_by_travelers through saved_communities' do
        community = create(:community)
        expect(community).to respond_to(:saved_by_travelers)
      end

      it 'can access travelers who saved the community' do
        community = create(:community)
        traveler1 = create(:traveler)
        traveler2 = create(:traveler)
        create(:saved_community, community: community, traveler: traveler1)
        create(:saved_community, community: community, traveler: traveler2)

        expect(community.saved_by_travelers).to contain_exactly(traveler1, traveler2)
      end
    end
  end

  describe 'validations' do
    describe 'community_name presence' do
      it 'is valid with a community_name' do
        community = build(:community, community_name: 'Test Community')
        expect(community).to be_valid
      end

      it 'is invalid without a community_name' do
        community = build(:community, community_name: nil)
        expect(community).not_to be_valid
        expect(community.errors[:community_name]).to include("can't be blank")
      end

      it 'is invalid with an empty community_name' do
        community = build(:community, community_name: '')
        expect(community).not_to be_valid
        expect(community.errors[:community_name]).to include("can't be blank")
      end
    end

    describe 'community_name format' do
      it 'is valid with letters and spaces' do
        community = build(:community, community_name: 'Green Valley')
        expect(community).to be_valid
      end

      it 'is invalid with numbers' do
        community = build(:community, community_name: 'Community123')
        expect(community).not_to be_valid
        expect(community.errors[:community_name]).to include("only allows letters and spaces")
      end

      it 'is invalid with special characters' do
        community = build(:community, community_name: 'Community!')
        expect(community).not_to be_valid
        expect(community.errors[:community_name]).to include("only allows letters and spaces")
      end
    end

    describe 'description presence' do
      it 'is valid with a description' do
        community = build(:community, description: 'A wonderful community')
        expect(community).to be_valid
      end

      it 'is invalid without a description' do
        community = build(:community, description: nil)
        expect(community).not_to be_valid
        expect(community.errors[:description]).to include("can't be blank")
      end

      it 'is invalid with an empty description' do
        community = build(:community, description: '')
        expect(community).not_to be_valid
        expect(community.errors[:description]).to include("can't be blank")
      end
    end
  end

  describe 'alias attributes' do
    it 'aliases name as community_name' do
      community = create(:community, name: 'Springfield')
      expect(community.community_name).to eq('Springfield')
    end

    it 'can set community_name using the alias' do
      community = create(:community)
      community.community_name = 'Portland'
      expect(community.name).to eq('Portland')
    end
  end

  describe 'FriendlyId' do
    it 'generates a slug from the name' do
      community = create(:community, name: 'Green Valley')
      expect(community.slug).to eq('green-valley')
    end

    it 'can be found by slug' do
      community = create(:community, name: 'Green Valley')
      found_community = described_class.friendly.find('green-valley')
      expect(found_community).to eq(community)
    end

    it 'preserves slug when name changes (FriendlyId behavior)' do
      community = create(:community, name: 'Green Valley')
      original_slug = community.slug

      community.update(name: 'Blue Mountain')
      community.reload

      expect(community.slug).to eq(original_slug)
    end

    it 'has a unique slug' do
      community = create(:community, name: 'Test Community')
      expect(community.slug).to be_present
      expect(described_class.where(slug: community.slug).count).to eq(1)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      community = build(:community)
      expect(community).to be_valid
    end

    it 'creates a community with a name' do
      community = create(:community)
      expect(community.name).to be_present
    end

    it 'creates a community with a description' do
      community = create(:community)
      expect(community.description).to be_present
    end

    it 'creates a community with a town' do
      community = create(:community)
      expect(community.town).to be_present
      expect(community.town).to be_a(Town)
    end
  end

  describe 'database columns' do
    it 'has a name column' do
      community = create(:community, name: 'Test Community')
      expect(community.name).to eq('Test Community')
    end

    it 'has a description column' do
      community = create(:community, description: 'A great place')
      expect(community.description).to eq('A great place')
    end

    it 'has a slug column' do
      community = create(:community)
      expect(community.slug).to be_present
    end

    it 'has a hero_image_url column' do
      community = create(:community, hero_image_url: 'https://example.com/image.jpg')
      expect(community.hero_image_url).to eq('https://example.com/image.jpg')
    end

    it 'has a town_id foreign key' do
      community = create(:community)
      expect(community.town_id).to be_present
    end

    it 'has a community_center_site_id foreign key' do
      community = create(:community)
      expect(community).to respond_to(:community_center_site_id)
    end

    it 'has timestamps' do
      community = create(:community)
      expect(community.created_at).to be_present
      expect(community.updated_at).to be_present
    end
  end
end
