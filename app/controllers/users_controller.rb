class UsersController < ApplicationController
  before_action :set_user
  before_action :authorize_user

  def show
  end
end
