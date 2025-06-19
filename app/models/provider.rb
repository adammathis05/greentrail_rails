class Provider < ApplicationRecord
  belongs_to :community
  belongs_to :site, optional: true

  has_many :provider_tags, dependent: :destroy
  has_many :tags, through: :provider_tags

  alias_attribute :provider_name, :name

  validates :provider_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :service, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
end
