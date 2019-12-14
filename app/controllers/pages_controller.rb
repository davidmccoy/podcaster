#
class PagesController < ApplicationController
  before_action :set_page
  before_action :authorize_page, except: [:index, :show, :feed, :mtgcast]

  def index
    # :latest_post is restricted to on post, but eager loading :postable ends up
    # eager loading many more than one associated postable records, so I'm leaving
    # that n+1 for now
    @pages = Page.includes(:logo, :latest_post).joins('INNER JOIN posts ON posts.page_id = pages.id').where('posts.publish_time < ?', Time.now).group('pages.id').order('max(posts.publish_time) DESC').paginate(page: params[:page], per_page: 12)
    @default_logo = ActionController::Base.helpers.asset_path('mtgcast-logo-itunes.png')
  end

  def show
    if @page.user == current_user
      @posts = @page.posts.includes(:postable).order(publish_time: :desc)
                    .paginate(page: params[:page], per_page: 12)
    else
      @posts = @page.posts.published.includes(:postable)
                    .paginate(page: params[:page], per_page: 12)
    end

    @first_post = @posts.first
    @logo_url =
      if @page.logo
        ActionController::Base.helpers.image_path(@page.logo.url(:medium))
      else
        ActionController::Base.helpers.image_path('mtgcast-logo-itunes.png')
      end
  end

  def new
    @page = Page.new
  end

  def create
    @page = current_user.pages.new(page_params)

    if @page.save
      flash[:notice] = 'Successfully created podcast.'
      redirect_to page_path(@page)
    else
      flash[:alert] = 'Failed to created podcast.'
      render :new
    end
  end

  def settings; end

  def edit; end

  def update
    if @page.update(page_params)
      flash[:notice] = 'Successfully updated podcast.'
      redirect_to page_path(@page)
    else
      flash[:alert] = 'Failed to update podcast.'
      render :edit
    end
  end

  def delete; end

  def destroy
    if @page.destroy
      flash[:notice] = 'Successfully deleted podcast.'
      redirect_to user_pages_path
    else
      flash[:alert] = 'Failed to delete podcast.'
      redirect_to page_delete_path(@page_)
    end
  end

  def feed
    @posts = @page.posts.published.includes(postable: :audio).limit(50)
    @image = ActionController::Base.helpers.asset_path('mtgcast-logo-itunes.png', host: root_url)
    @email =
      if @page.user.email == 'david.mccoy@gmail.com'
        'admin@mtgcast.fm'
      else
        @page.user.email
      end
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
    @posts = Post.published
                 .includes(:page)
                 .preload(postable: :audio)
                 .where(pages: { included_in_aggregate_feed: true }).limit(100)
    @date =
      if @posts.first
        @posts.first.publish_time.to_s(:rfc822)
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
    params.require(:page).permit(:name)
  end

  def set_logo_url
  end
end
