class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  # use Pundit to redirect after failed auth
  def user_not_authorized
    if current_user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path) and return
    else
      redirect_to new_user_registration_path(url: request.path) and return
    end
  end

  def record_not_found
    render 'errors/not_found' # Assuming you have a template named 'record_not_found'
  end

  # ======= customize devise ======= #

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  end

  def after_sign_in_path_for(resource)
    if resource.multiple_podcasts
      user_pages_path
    elsif resource.pages.any?
      page_admin_posts_path(resource.pages.first)
    else
      super
    end
  end

  # ======= custom methods to set records and authorize them ======= #

  def set_user
    @user = User.find_by_id(params[:user_id]) || User.find_by_id(params[:id])
    raise ActiveRecord::RecordNotFound unless @user
  end

  def authorize_user
    @user ||= User.new
    authorize @user
  end

  def set_page
    @page = Page.find_by_slug(params[:page_slug]) || Page.find_by_slug(params[:slug])
    raise ActiveRecord::RecordNotFound unless @page
  end

  def authorize_page
    @page ||= Page.new
    authorize @page
  end

  def set_post
    @post = Post.includes(:postable).find_by_slug(params[:post_slug]) || Post.includes(:postable).find_by_slug(params[:slug])
    raise ActiveRecord::RecordNotFound unless @post
  end

  def authorize_post
    @post ||= @page.posts.build
    authorize @post
  end

  def set_audio
    @audio = Audio.find_by_id(params[:audio_id]) || Audio.find_by_id(params[:id])
    raise ActiveRecord::RecordNotFound unless @audio
  end
end
