class Community < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :town
  belongs_to :community_center_site, class_name: "Site", optional: true

  has_many :sites, through: :town
  has_many :providers, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :saved_communities, dependent: :destroy
  has_many :saved_by_travelers, through: :saved_communities, source: :traveler

  alias_attribute :community_name, :name

  validates :community_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :description, presence: true
end
