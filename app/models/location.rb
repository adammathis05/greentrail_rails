class Location < ApplicationRecord
    # Shared logic and validations here
    alias_attribute :location_name, :name
end
