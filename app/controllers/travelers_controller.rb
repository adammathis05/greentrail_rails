class TravelersController < ApplicationController
  def new
    @traveler = Traveler.new
  end

  def create
    @traveler = Traveler.new(traveler_params)
    if @traveler.save
      redirect_to @traveler, notice: "Account created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @traveler = Traveler.find(params[:id])
  end

  def edit
    @traveler = Traveler.find(params[:id])
  end

  def update
    @traveler = Traveler.find(params[:id])
    if @traveler.update(traveler_params)
      redirect_to @traveler, notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def traveler_params
    params.require(:traveler).permit(:first, :last, :email)
  end
end