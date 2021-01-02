#
class Dashboard::LogosController < ApplicationController
  before_action :set_page

  def new; end

  def create
    @logo = @page.build_logo(logo_params.merge(page_info))
    if @logo.save
      flash[:notice] = 'Successfully uploaded logo.'
      redirect_to page_dashboard_settings_path(@page)
    else
      flash[:alert] = 'Failed to upload logo.'
      render :new
    end
  end

  def edit
    @logo = @page.logo
  end

  def update
    if @page.logo.update(logo_params)
      flash[:notice] = 'Successfully uploaded logo.'
      redirect_to page_dashboard_settings_path(@page)
    else
      flash[:alert] = 'Failed to upload logo.'
      render :edit
    end
  end

  private

  def logo_params
    params.require(:logo).permit(:id, :file)
  end

  def page_info
    { attachable_type: 'Page', attachable_id: @page.id, label: 'logo' }
  end
end
