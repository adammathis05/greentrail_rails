class EventSeries < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :community
  belongs_to :site, optional: true

  alias_attribute :event_series_name, :name

  validates :event_series_name, :category, :description, presence: true
end
