class Community < ApplicationRecord
  belongs_to :town
  belongs_to :community_center_site, class_name: "Site", optional: true

  has_many :sites, dependent: :destroy
  has_many :providers, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :community_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :description, presence: true
end
