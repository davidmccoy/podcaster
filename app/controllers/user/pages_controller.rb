#
class User::PagesController < ApplicationController
  before_action :set_page, except: [:index, :new, :create]
  before_action :authorize_page

  def index
    @pages = current_user.pages
  end

  def new
    @page = Page.new
  end

  def create
    @page = current_user.pages.new(page_params)

    if @page.save
      flash[:notice] = 'Successfully created podcast.'
      redirect_to page_path(@page)
    else
      flash[:alert] = 'Failed to created podcast.'
      render :new
    end
  end

  private

  def page_params
    params.require(:page).permit(:name)
  end
end
