#
class Dashboard::AnalyticsController < Dashboard::BaseController
  before_action :set_page
  before_action :authorize_page

  def show
    @posts = @page.posts.where(postable_type: "AudioPost")
                        .includes(:postable)
                        .order(publish_time: :desc)
                        .paginate(page: params[:page], per_page: 20)
  end

  def audience
    @posts = @page.posts.where(postable_type: "AudioPost")
                        .includes(:postable)
                        .order(publish_time: :desc)
                        .paginate(page: params[:page], per_page: 20)
  end

  def downloads
    @posts = @page.posts.where(postable_type: "AudioPost")
                        .includes(:postable)
                        .order(publish_time: :desc)
                        .paginate(page: params[:page], per_page: 20)
  end
end
