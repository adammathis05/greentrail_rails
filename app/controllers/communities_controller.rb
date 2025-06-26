class CommunitiesController < ApplicationController
  before_action :authenticate_traveler!, unless: :public_page?
  before_action :set_community, only: [:show]

  def show
    @all_categories = ["Explore", "Stay", "Eat", "Events", "Amenities"]
    @grouped_providers = @community.providers.includes(:site, :tags).group_by { |p| p.category.titleize }
  end

  private

  def set_community
    @community = Community.friendly.find(params[:id])
  end
end