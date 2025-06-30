class PagesController < ApplicationController
  skip_before_action :authenticate_traveler!, only: [:home, :about, :contact]

  def home
    if traveler_signed_in?
      @featured_community = Community.order("RANDOM()").first
    end
  end

  def about
  end

  def contact
  end
end
