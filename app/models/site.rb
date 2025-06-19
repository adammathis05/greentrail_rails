class Site < ApplicationRecord
  belongs_to :town
  belongs_to :community

  has_many :providers, dependent: :destroy

  alias_attribute :site_name, :name

  validates :site_name, presence: true
  validates :site_name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
end
