class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_traveler

  def current_traveler
    # return nil until Devise or session auth is set up
    nil
  end
  
end
