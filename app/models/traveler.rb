class Traveler < ApplicationRecord
  validates :first, presence: true
  validates :last, presence: true
  validates :email, presence: true

  def full_name
    "#{first} #{last}"
  end
end
