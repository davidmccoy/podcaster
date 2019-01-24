class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # use Pundit to redirect after failed auth
  def user_not_authorized
    if current_user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path) and return
    else
      flash[:alert] = "You'll have to sign in before you can do that!"
      redirect_to new_user_session_path(url: request.path) and return
    end
  end

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

  def set_page
    @page = Page.find_by_slug(params[:page_id]) || Page.find_by_slug(params[:id])
  end

  def set_post
    @post = Post.find_by_id(params[:post_id]) || Post.find_by_id(params[:id])
  end
end
