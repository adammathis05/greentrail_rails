class Traveler < ApplicationRecord
  validates :first, :last, :email, presence: true

  def full_name
    "#{first} #{last}"
  end
end
