# Public posts controller, accessible to all users.
class PostsController < ApplicationController
  before_action :set_page
  before_action :set_post, except: [:index]
  before_action :authorize_post

  def index
    @posts = @page.posts.published.includes(:postable)
              .order(publish_time: :desc)
              .paginate(page: params[:page], per_page: 20)
  end

  def show
    @logo_url =
      if @page.logo
        ActionController::Base.helpers.image_path(@page.logo.url(:medium))
      else
        ActionController::Base.helpers.image_path('mtgcast-logo-itunes.png')
      end
  end
end
