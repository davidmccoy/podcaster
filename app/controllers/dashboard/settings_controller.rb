# Only accessible by page admins
class Dashboard::SettingsController < ApplicationController
  before_action :set_page
  before_action :authorize_page

  def show; end

  def edit; end

  def update
    if @page.update(page_params)
      flash[:notice] = 'Successfully updated podcast.'
      redirect_to edit_page_dashboard_settings_path(@page)
    else
      flash[:alert] = 'Failed to update podcast.'
      render :edit
    end
  end

  def delete; end

  def destroy
    if @page.destroy
      flash[:notice] = 'Successfully deleted podcast.'
      redirect_to user_pages_path
    else
      flash[:alert] = 'Failed to delete podcast.'
      redirect_to page_delete_path(@page_)
    end
  end

  private

  def page_params
    params.require(:page).permit(:name, :description)
  end
end
