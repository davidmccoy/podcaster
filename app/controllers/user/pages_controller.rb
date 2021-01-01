#
class User::PagesController < ApplicationController
  before_action :set_page, except: [:index, :new, :create, :upload]
  before_action :authorize_page

  def index
    @pages = current_user.pages
  end

  def upload
    @pages = current_user.pages

    if @pages.length == 1
      redirect_to new_page_post_path(@pages.first)
    elsif @pages.length > 1
      redirect_to user_pages_path
    else
      redirect_to new_page_path
    end
  end

  private

  def page_params
    params.require(:page).permit(:name)
  end
end
