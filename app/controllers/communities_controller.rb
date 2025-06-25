class CommunitiesController < ApplicationController
  before_action :authenticate_traveler!, unless: :public_page?
  before_action :set_community, only: [:show]

  def show
  @community = Community.friendly.find(params[:id])
  @grouped_providers = traveler_signed_in? ? @community.providers.includes(:site, :tags).group_by(&:category) : {}
  @all_categories = Provider.categories.keys.map(&:titleize)
end

  private

  def set_community
    @community = Community.friendly.find(params[:id])
  end
end