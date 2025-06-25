class Provider < ApplicationRecord
  belongs_to :community
  belongs_to :site, optional: true

  has_many :provider_tags, dependent: :destroy
  has_many :tags, through: :provider_tags

  alias_attribute :provider_name, :name

  enum category: {
    explore: "Explore",
    eat: "Eat",
    stay: "Stay",
    events: "Events",
    amenities: "Amenities"
  }

  validates :description, :category, presence: true
  validates :provider_name, presence: true
  validates :service, presence: true
end
