class User::RegistrationsController < Devise::RegistrationsController
  before_action :authorize_user, except: [:new, :create]

  def show
    @user = current_user
  end

  def password
  end

  def update_password
    @user = current_user

    if valid_current_password? && @user.update(user_params)
      bypass_sign_in(@user)
      flash[:notice] = 'Successfully changed your password'
      redirect_to user_registration_path
    else
      flash[:alert] = 'Something\'s not quite right.'
      render 'password'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def current_password_params
    params.permit(:current_password)
  end

  def valid_current_password?
    @user.valid_password? current_password_params[:current_password]
  end

  def after_update_path_for(resource)
    user_registration_path
  end

  def after_sign_up_path_for(resource)
    redirect_url_params = params[:url]
    redirect_url = Rails.application.routes.recognize_path(redirect_url_params)

    if redirect_url 
      return params[:url]
    else 
      return '/'
    end 
  rescue 
    '/'
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
