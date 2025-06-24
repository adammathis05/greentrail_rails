class LocationsController < ApplicationController

  before_action :authenticate_traveler!, unless: :public_page?
  before_action :set_location, only: [:show]

  def index
    @countries = Country.all
  end

  def show
    @location = Location.find(params[:id])

    case @location
    when Country
      @children = @location.provinces
      @child_type = "Provinces"
    when Province
      @children = @location.towns
      @child_type = "Towns"
    when Town
      community = @location.community
      if community.present?
        redirect_to community_path(community.slug) and return
      else
        redirect_to locations_path, alert: "This town does not have a community yet." and return
      end
    else
      @children = []
      @child_type = nil
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end
end
