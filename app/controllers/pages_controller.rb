#
class PagesController < ApplicationController
  before_action :set_page, except: [:index, :new, :create, :mtgcast, :recover, :send_recovery_email]
  before_action :authorize_page, except: [:index, :show, :feed, :mtgcast]

  def index
    @pages = Page::Search.new(Page.all, query_params, params).all

    @default_logo = ActionController::Base.helpers.asset_path('mtgcast-logo-itunes.png')
  end

  def show
    @posts = @page.posts.published.includes(:postable)
                  .paginate(page: params[:page], per_page: 15)

    @logo_url =
      if @page.logo
        ActionController::Base.helpers.image_path(@page.logo.url(:medium))
      else
        ActionController::Base.helpers.image_path('mtgcast-logo-itunes.png')
      end

    @shortened = @page.description&.to_plain_text&.length > 300
  end

  def new
    @page = Page.new
  end

  def create
    @page = current_user.pages.new(page_params)

    if @page.save
      flash[:notice] = 'Welcome to MTGCast! Don\'t forget to add a description and category!'
      redirect_to page_dashboard_settings_path(@page)
    else
      flash[:alert] = 'Failed to created podcast.'
      render :new
    end
  end

  def feed
    @episodes = @page.audio_posts
                  .published
                  .includes(:audio, :rich_text_content, :post)
                  .limit(50)
                  .select { |episode| episode.audio.any? }
                  # this select is gross but necessary for episodes without audio

    @image =
      if @page.logo
        @page.logo.url(:large)
      else
        ActionController::Base.helpers.asset_path('mtgcast-logo-itunes.png', host: root_url)
      end
    @email =
      if @page.user&.email == 'david.mccoy@gmail.com'
        'admin@mtgcast.fm'
      elsif @page.user
        @page.user.email
      else
        'admin@mtgcast.fm'
      end
    @date =
      if @episodes.first
        @episodes.first.publish_time.to_s(:rfc822)
      else
        Time.now.to_s(:rfc822)
      end
    render template: 'pages/feed.rss.builder', layout: false
  end

  def mtgcast
    @image = ActionController::Base.helpers.asset_path('mtgcast-logo-itunes.png', host: root_url)
    @episodes = AudioPost.published
                 .includes(post: :page)
                 .preload(:audio, :rich_text_content)
                 .where(pages: { included_in_aggregate_feed: true }).limit(100)
    @date =
      if @episodes.first
        @episodes.first.publish_time.to_s(:rfc822)
      else
        Time.now.to_s(:rfc822)
      end
    render template: 'pages/mtgcast_feed.rss.builder', layout: false
  end

  def recover
    @podcasts = Page.where(user_id: nil).order(:name).pluck(:name)
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

  def page_params
    params.require(:page).permit(:name, :description)
  end

  def query_params
    params.permit(:term, :category, :sort_by)
  end
end
