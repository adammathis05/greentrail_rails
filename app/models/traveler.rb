class Traveler < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true

    def full_name
        "#{first} #{last}"
    end
end
