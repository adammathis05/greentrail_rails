class CommunitiesController < ApplicationController
  before_action :authenticate_traveler!, unless: :public_page?
  before_action :set_community, only: [:show]

  def show
    @providers = @community.providers.includes(:site, :tags)
    @grouped_providers = @providers.group_by(&:category)
  end

  private

  def set_community
  @community = Community.friendly.find(params[:id])
end
end