class Town < ApplicationRecord
  belongs_to :province
  has_one :community, dependent: :destroy
  has_many :sites, dependent: :destroy
end
