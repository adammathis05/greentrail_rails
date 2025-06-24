class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_traveler!, unless: :public_page?

  helper_method :current_traveler

  # def current_traveler
  #   # return nil until Devise or session auth is set up
  #   nil
  # end
  
  protected

  def after_sign_in_path_for(resource)
    traveler_path(resource) # or customize based on role later
  end

  # Devise: redirect after sign out
  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def redirect_if_authenticated
    if traveler_signed_in?
      redirect_to traveler_path(current_traveler), notice: "You're already signed in."
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first, :last])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first, :last])
  end

  private

  def public_page?
    devise_controller? || 
    (controller_name == "pages" && action_name == "home") ||
    (controller_name == "communities" && %w[index show].include?(action_name)) ||
    (controller_name == "locations" && %w[index show].include?(action_name))
  end

  def admin_only!
    unless current_traveler&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
