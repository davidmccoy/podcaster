class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # ======= customize devise ======= #

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  end

  # ======= custom methods to set records and authorize them ======= #

  def set_user
    @user = User.find_by_id(params[:user_id]) || User.find_by_id(params[:id])
  end

  def authorize_user
    @user ||= User.new
    authorize @user
  end
end
