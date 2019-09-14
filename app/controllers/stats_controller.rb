#
class StatsController < ApplicationController
  before_action :set_page

  def index
    @posts = @page.posts.includes(:postable)
                        .order(publish_time: :desc)
                        .paginate(page: params[:page], per_page: 20)
  end
end