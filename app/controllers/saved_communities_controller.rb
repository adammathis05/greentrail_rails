class SavedCommunitiesController < ApplicationController
  before_action :authenticate_traveler!

  def create
    community = Community.find(params[:community_id])
    current_traveler.saved_communities.create!(community: community)
    redirect_back fallback_location: dashboard_path, notice: "Community added to favorites"
  end

  def destroy
    saved = current_traveler.saved_communities.find_by!(community_id: params[:community_id])
    saved.destroy
    redirect_back fallback_location: dashboard_path, notice: "Community removed from favorites"
  end
end
