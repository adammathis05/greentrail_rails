class TravelersController < ApplicationController
  before_action :authenticate_traveler!


  def show
    @traveler = Traveler.find(params[:id])
  end

  def edit
    @traveler = Traveler.find(params[:id])
  end

  def update
    @traveler = Traveler.find(params[:id])
    if @traveler.update(traveler_params)
      flash[:notice] = "Profile updated successfully"
      redirect_to @traveler
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @traveler = Traveler.find(params[:id])
    @traveler.destroy
  flash[:notice] = "Traveler account successfully deleted."
  redirect_to root_path
  end 

  private

  def traveler_params
    params.require(:traveler).permit(:first, :last, :email)
  end
end