class Site < ApplicationRecord
  belongs_to :town
  belongs_to :community
end
