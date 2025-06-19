class ProviderTag < ApplicationRecord
  belongs_to :provider
  belongs_to :tag

  validates :provider_id, presence: true
  validates :tag_id, presence: true

  validates :tag_id, uniqueness: { scope: :provider_id, message: "has already been added to this provider" }
end
