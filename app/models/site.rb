class Site < ApplicationRecord
  belongs_to :town
  belongs_to :community

  has_many :providers, dependent: :destroy

  alias_attribute :site_name, :name

  validates :site_name, presence: true
end
