# Public posts controller, accessible to all users.
class PodcastEpisodesController < ApplicationController
  before_action :set_page

  def index
    @posts = @page.posts.where(postable_type: "PodcastEpisode").includes(:postable)
              .order(publish_time: :desc)
              .paginate(page: params[:page], per_page: 20)

    @logo_url =
      if @page.logo
        ActionController::Base.helpers.image_path(@page.logo.url(:medium))
      else
        ActionController::Base.helpers.image_path('mtgcast-logo-itunes.png')
      end
  end
end
