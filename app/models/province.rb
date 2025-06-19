class Province < ApplicationRecord
  belongs_to :country
  has_many :towns, dependent: :destroy
end
