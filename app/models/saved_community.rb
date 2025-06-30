class SavedCommunity < ApplicationRecord
  belongs_to :traveler
  belongs_to :community

  validates :traveler_id, uniqueness: { scope: :community_id }
end
