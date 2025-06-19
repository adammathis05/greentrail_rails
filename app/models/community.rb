class Community < ApplicationRecord
  belongs_to :town
  has_many :sites, dependent: :destroy
  has_many :providers, dependent: :destroy
  has_many :events, dependent: :destroy
end
