class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_redirect_path, if: -> { devise_controller? && params[:redirect_to].present? }
  before_action :authenticate_traveler!, unless: :public_page?


  helper_method :current_traveler

  # def current_traveler
  #   # return nil until Devise or session auth is set up
  #   nil
  # end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first, :last])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first, :last])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:redirect_to])
  end

  def store_redirect_path
    store_location_for(:traveler, params[:redirect_to])
  end

  def after_sign_up_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || locations_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

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