class Tag < ApplicationRecord
  has_many :provider_tags, dependent: :destroy
  has_many :providers, through: :provider_tags

  alias_attribute :name, :tag_name

  validates :name, presence: true, uniqueness: true
end
