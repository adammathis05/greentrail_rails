class Provider < ApplicationRecord
  belongs_to :site
  belongs_to :community
end
