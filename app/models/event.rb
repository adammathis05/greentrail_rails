class Event < ApplicationRecord
  belongs_to :community
  belongs_to :site, optional: true
  has_many :event_series, dependent: :destroy

  alias_attribute :event_name, :title

  validates :event_name, :date, :category, :description, presence: true
end
