# Only accessible by page admins
class Dashboard::PostsController < ApplicationController
  before_action :set_page
  before_action :set_post, except: [:index, :new, :create]
  before_action :authorize_post, except: [:show]

  def index
    @posts = @page.posts
              .includes(:postable)
              .order(publish_time: :desc)
              .paginate(page: params[:page], per_page: 20)
  end
end
