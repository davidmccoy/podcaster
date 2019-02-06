#
class PagesController < ApplicationController
  before_action :set_page
  before_action :authorize_page, except: [:index, :show, :feed, :mtgcast]

  def index
    @pages = Page.joins('INNER JOIN posts ON posts.page_id = pages.id').where('posts.publish_time < ?', Time.now).group('pages.id').order('max(posts.publish_time) DESC').paginate(page: params[:page], per_page: 10)
  end

  def show
    if @page.user == current_user
      @posts = @page.posts.includes(:postable).order(publish_time: :desc)
                    .paginate(page: params[:page], per_page: 10)
    else
      @posts = @page.posts.published.includes(:postable)
                    .paginate(page: params[:page], per_page: 10)
    end
  end

  def feed
    @posts = @page.posts.published.includes(postable: :audio).limit(50)
    @image = ActionController::Base.helpers.asset_path('mtgcast-logo-itunes.png', host: root_url)
    @date =
      if @page.posts.published.first
        @page.posts.published.first.publish_time.to_s(:rfc822)
      else
        Time.now.to_s(:rfc822)
      end
    render template: 'pages/feed.rss.builder', layout: false
  end

  def mtgcast
    @image = ActionController::Base.helpers.asset_path('mtgcast-logo-itunes.png', host: root_url)
    @episodes = Post.published.includes(:page, postable: :audio).limit(100)
    @date =
      if @episodes.first
        @episodes.first.publish_time.to_s(:rfc822)
      else
        Time.now.to_s(:rfc822)
      end
    render template: 'pages/mtgcast_feed.rss.builder', layout: false
  end

  def recover
    @podcasts = Page.all.order(:name).pluck(:name)
  end

  def send_recovery_email
    PageRecoveryMailer.new_recovery_request(recovery_email_params[:name], recovery_email_params[:email], recovery_email_params[:podcast_name], recovery_email_params[:description]).deliver_later
    flash[:notice] = 'Successfully submitted your request.'
    redirect_to user_pages_path
  end

  private

  def recovery_email_params
    params.permit(:name, :email, :podcast_name, :description)
  end
end
