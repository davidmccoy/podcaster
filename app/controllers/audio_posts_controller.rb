# Public posts controller, accessible to all users.
class AudioPostsController < ApplicationController
  before_action :set_page

  def index
    @posts = @page.posts
              .published
              .includes(:postable)
              .where(postable_type: "AudioPost")
              .order(publish_time: :desc)
              .paginate(page: params[:page], per_page: 20)

    @logo_url =
      if @page.logo
        ActionController::Base.helpers.image_path(@page.logo.url(:medium))
      else
        ActionController::Base.helpers.image_path('mtgcast-logo-itunes.png')
      end

      @shortened = @page.description&.to_plain_text&.length > 300
  end
end
