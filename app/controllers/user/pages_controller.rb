#
class User::PagesController < ApplicationController
  before_action :set_page, except: [:index, :new, :create]
  before_action :authorize_page

  def index
    @pages = current_user.pages
  end

  private

  def page_params
    params.require(:page).permit(:name)
  end
end
