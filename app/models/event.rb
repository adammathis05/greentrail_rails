class Event < ApplicationRecord
  belongs_to :community
  has_many :event_series, dependent: :destroy
end
