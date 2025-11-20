require 'rails_helper'

RSpec.describe SavedCommunity, type: :model do
  describe 'associations' do
    describe 'belongs_to traveler' do
      it 'belongs to a traveler' do
        traveler = create(:traveler)
        saved_community = create(:saved_community, traveler: traveler)

        expect(saved_community.traveler).to eq(traveler)
      end

      it 'is invalid without a traveler' do
        saved_community = build(:saved_community, traveler: nil)
        expect(saved_community).not_to be_valid
      end
    end

    describe 'belongs_to community' do
      it 'belongs to a community' do
        community = create(:community)
        saved_community = create(:saved_community, community: community)

        expect(saved_community.community).to eq(community)
      end

      it 'is invalid without a community' do
        saved_community = build(:saved_community, community: nil)
        expect(saved_community).not_to be_valid
      end
    end
  end

  describe 'validations' do
    describe 'traveler_id uniqueness scoped to community_id' do
      it 'is valid when a traveler saves different communities' do
        traveler = create(:traveler)
        community1 = create(:community)
        community2 = create(:community)

        saved_community1 = create(:saved_community, traveler: traveler, community: community1)
        saved_community2 = build(:saved_community, traveler: traveler, community: community2)

        expect(saved_community2).to be_valid
      end

      it 'is invalid when a traveler saves the same community twice' do
        traveler = create(:traveler)
        community = create(:community)

        create(:saved_community, traveler: traveler, community: community)
        duplicate_saved_community = build(:saved_community, traveler: traveler, community: community)

        expect(duplicate_saved_community).not_to be_valid
        expect(duplicate_saved_community.errors[:traveler_id]).to include("has already been taken")
      end

      it 'is valid when different travelers save the same community' do
        traveler1 = create(:traveler)
        traveler2 = create(:traveler)
        community = create(:community)

        saved_community1 = create(:saved_community, traveler: traveler1, community: community)
        saved_community2 = build(:saved_community, traveler: traveler2, community: community)

        expect(saved_community2).to be_valid
      end
    end
  end

  describe 'factory' do
    it 'creates a saved_community with a traveler' do
      saved_community = create(:saved_community)
      expect(saved_community.traveler).to be_present
      expect(saved_community.traveler).to be_a(Traveler)
    end

    it 'creates a saved_community with a community' do
      saved_community = create(:saved_community)
      expect(saved_community.community).to be_present
      expect(saved_community.community).to be_a(Community)
    end
  end

  describe 'database columns' do
    it 'has a traveler_id foreign key' do
      saved_community = create(:saved_community)
      expect(saved_community.traveler_id).to be_present
    end

    it 'has a community_id foreign key' do
      saved_community = create(:saved_community)
      expect(saved_community.community_id).to be_present
    end

    it 'has timestamps' do
      saved_community = create(:saved_community)
      expect(saved_community.created_at).to be_present
      expect(saved_community.updated_at).to be_present
    end
  end

  describe 'join table behavior' do
    it 'allows a traveler to save multiple communities' do
      traveler = create(:traveler)
      community1 = create(:community)
      community2 = create(:community)
      community3 = create(:community)

      create(:saved_community, traveler: traveler, community: community1)
      create(:saved_community, traveler: traveler, community: community2)
      create(:saved_community, traveler: traveler, community: community3)

      expect(traveler.saved_community_records.count).to eq(3)
      expect(traveler.saved_community_records).to contain_exactly(community1, community2, community3)
    end

    it 'allows a community to be saved by multiple travelers' do
      community = create(:community)
      traveler1 = create(:traveler)
      traveler2 = create(:traveler)
      traveler3 = create(:traveler)

      create(:saved_community, traveler: traveler1, community: community)
      create(:saved_community, traveler: traveler2, community: community)
      create(:saved_community, traveler: traveler3, community: community)

      expect(community.saved_by_travelers.count).to eq(3)
      expect(community.saved_by_travelers).to contain_exactly(traveler1, traveler2, traveler3)
    end
  end
end
