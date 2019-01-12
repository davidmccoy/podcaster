class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authorize_user

  def show
    @user = current_user
  end

  protected

  def after_update_path_for(resource)
    user_registration_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
