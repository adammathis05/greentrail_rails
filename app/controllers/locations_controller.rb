class LocationsController < ApplicationController

    def index
        @locations = ["Chacala, Mexico", "Monterey, CA", "Siem Reap, Cambodia", "Lisbon, Portugal"]
    end

end
