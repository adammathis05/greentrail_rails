class LocationsController < ApplicationController

    before_action :authenticate_traveler!, unless: :public_page?
  before_action :set_location, only: [:show]

  def index
    @countries = Country.all
  end

  def show
    case @location
    when Country
      @provinces = @location.provinces
      render :country
    when Province
      @towns = @location.towns
      render :province
    when Town
      if @location.community
        redirect_to community_path(@location.community)
      else
        redirect_to locations_path, alert: "No community found for this town."
      end
    else
      redirect_to locations_path, alert: "Invalid location."
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

end
