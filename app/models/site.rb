class Site < ApplicationRecord
  belongs_to :town
  belongs_to :community
  has_many :providers, dependent: :destroy
end
