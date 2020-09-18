class HomeController < ApplicationController
  def index
    # handle old MTGCast feed locations
    redirect_to feed_path, status: 301 if previous_locations

    @page = Page.includes(:logo, :latest_post).first
  end

  private

  def feed_params
    params.permit(:feed)
  end

  def previous_locations
    feed_params[:feed] == 'podcast' || request.formats.include?('application/xml')
  end
end
