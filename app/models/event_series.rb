class EventSeries < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :community
  belongs_to :site, optional: true

  validates :event_series_name, :category, :description, presence: true
end
