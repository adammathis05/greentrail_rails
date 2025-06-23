class TravelersController < ApplicationController
  def new
    @traveler = Traveler.new
  end

  def create
    @traveler = Traveler.new(traveler_params)
    if @traveler.save
      flash[:notice] = "Profile created successfully"
      redirect_to @traveler
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