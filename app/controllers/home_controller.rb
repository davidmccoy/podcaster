class HomeController < ApplicationController
  def index
    # handle old MTGCast feed locations
    redirect_to feed_path, status: 301 if feed_params[:feed] == 'podcast'
    redirect_to feed_path, status: 301 if request.formats.include? "application/xml"

    @page = Page.includes(:logo, :latest_post).first
  end

  private

  def feed_params
    params.permit(:feed)
  end
end
