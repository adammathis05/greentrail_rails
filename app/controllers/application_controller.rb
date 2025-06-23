class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?


  helper_method :current_traveler

  # def current_traveler
  #   # return nil until Devise or session auth is set up
  #   nil
  # end
  
  protected

  def redirect_if_authenticated
    if traveler_signed_in?
      redirect_to traveler_path(current_traveler), notice: "You're already signed in."
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first, :last])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first, :last])
  end
end
