class UsersController < ApplicationController
  before_action :set_user
  before_action :authorize_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated."
      redirect_to user_path(@user) and return
    else
      flash[:alert] = "Failed to update user."
      redirect_to edit_user_path(@user) and return
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
