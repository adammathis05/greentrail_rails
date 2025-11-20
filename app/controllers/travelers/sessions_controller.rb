# frozen_string_literal: true

class Travelers::SessionsController < Devise::SessionsController
  before_action :store_redirect_path, only: [ :new ]

  def create
    super
  end

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || session.delete(:redirect_to) || root_path
  end

  private

  def store_redirect_path
    if params[:redirect_to].present?
      session[:redirect_to] = params[:redirect_to]
    end
  end
end
