class Event < ApplicationRecord
  belongs_to :community
  belongs_to :site, optional: true
  has_many :event_series, dependent: :destroy

  alias_attribute :event_name, :title

  validates :event_name, :date, :category, :description, presence: true
  validates :event_name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
end
