# Only accessible by page admins
class Dashboard::PostsController < ApplicationController
  before_action :set_page
  before_action :authorize_post

  def index
    @posts = @page.posts
              .includes(:postable)
              .order(publish_time: :desc)
              .paginate(page: params[:page], per_page: 20)
  end
end
