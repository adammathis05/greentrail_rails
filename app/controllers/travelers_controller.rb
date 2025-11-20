class TravelersController < ApplicationController
  before_action :authenticate_traveler!


  def show
    @traveler = Traveler.find(params[:id])
  end

  def edit
    @traveler = current_traveler
  end

  def update
    @traveler = Traveler.find(params[:id])

    if @traveler.update(traveler_params.merge(role: @traveler.role))
      redirect_to traveler_path(@traveler), notice: "Profile updated successfully."
    else
      flash.now[:alert] = "Failed to update profile."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_traveler.destroy
    redirect_to root_path, notice: "Account deleted successfully."
  end

  def dashboard
    @traveler = current_traveler
    @saved_communities = current_traveler.saved_community_records
    @explore_communities = Community.where.not(id: @saved_communities.pluck(:id)).limit(6)
  end

  private

  def traveler_params
    params.require(:traveler).permit(
      :first,
      :last,
      :email,
      :birthdate,
      :home_city,
      :home_country,
      :profile_picture
    )
  end
end
