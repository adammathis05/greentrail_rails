class TravelersController < ApplicationController
  before_action :authenticate_traveler!


  def show
    @traveler = Traveler.find(params[:id])
  end

  def edit
    @traveler = current_traveler
  end

  def update
    @traveler = current_traveler
    if @traveler.update(traveler_params)
      redirect_to traveler_path(@traveler), notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_traveler.destroy
    redirect_to root_path, notice: "Account deleted successfully."
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