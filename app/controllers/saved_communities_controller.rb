class SavedCommunitiesController < ApplicationController
  before_action :authenticate_traveler!

  def create
    @community = Community.find(params[:community_id])
    SavedCommunity.find_or_create_by!(traveler: current_traveler, community: @community)
    redirect_back fallback_location: traveler_dashboard_path, notice: "Community added to your Dashboard"
  end

  def destroy
    saved = current_traveler.saved_communities.find_by!(community_id: params[:community_id])
    saved.destroy
    redirect_back fallback_location: traveler_dashboard_path, notice: "Community removed from your Dashboard"
  end
end
