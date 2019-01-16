class HomeController < ApplicationController
  def index
    # MTGCast feed
    if feed_params[:feed] == 'podcast'
      redirect_to feed_path
    end
  end

  private

  def feed_params
    params.permit(:feed)
  end
end