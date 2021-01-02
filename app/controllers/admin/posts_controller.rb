# Only accessible by page admins
class Admin::PostsController < ApplicationController
  before_action :set_page
  before_action :set_post, except: [:index, :new, :create]
  before_action :authorize_post, except: [:show]

  def index
    @posts = @page.posts.includes(:postable)
              .order(publish_time: :desc)
              .paginate(page: params[:page], per_page: 20)
  end

  # TODO: should this be a preview changes feature?
  # def show
  #   @logo_url =
  #     if @page.logo
  #       ActionController::Base.helpers.image_path(@page.logo.url(:medium))
  #     else
  #       ActionController::Base.helpers.image_path('mtgcast-logo-itunes.png')
  #     end
  # end

  def new
    @post = @page.posts.new(postable_type: PodcastEpisode) unless externally_hosted?
  end

  def create
    redirect_to page_admin_posts_path(@page) if externally_hosted?

    @post = Post.new(
      post_params.merge(
        page_id: @page.id,
        postable_type: PodcastEpisode,
        publish_time: formatted_publish_time,
        postable_attributes: post_params[:postable_attributes].merge(publish_time: formatted_publish_time)
      )
    )

    if @post.save
      @audio = Audio.create(
        attachment_params[:attachment].merge(
          attachable_type: @post.postable.class,
          attachable_id: @post.postable.id
        )
      )
      flash[:notice] = 'Successfully created your post!'
      redirect_to page_post_path(@page, @post) and return
    else
      flash[:alert] = 'You\'re missing a few things.'
      render :new and return
    end
  end

  def edit; end

  def update
    if @post.update(post_params.merge(publish_time: formatted_publish_time))
      @podcast_episode = @post.postable.podcast_episode
      if @podcast_episode
        @podcast_episode.update(attachment_params[:attachment])
      else
        @podcast_episode = Audio.create(
          attachment_params[:attachment].merge(
            attachable_type: @post.postable.class,
            attachable_id: @post.postable.id
          )
        )
      end
      flash[:notice] = 'Successfully updated post.'
    else
      flash[:alert] = 'Failed to update post.'
    end

    redirect_to edit_page_admin_post_path(@page, @post)
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Successfully deleted post.'
      redirect_to page_admin_posts_path(@page) and return
    else
      flash[:alert] = 'Failed to delete post.'
      redirect_to edit_page_admin_post_path(@page, @post) and return
    end
  end

  private

  def post_params
    params.require(:post)
          .permit(
            :id,
            :postable_type,
            :postable_id,
            :publish_time,
            :slug,
            postable_attributes: [
              :id,
              :title,
              :description,
              :content
            ]
          )
  end

  def date_params
    params.require(:post).permit(
      :publish_time_month,
      :publish_time_day,
      :publish_time_year,
      :publish_time_hour,
      :publish_time_minute,
      :publish_time_zone
    )
  end

  def attachment_params
    params.require(:post).permit(attachment: [:file, :label])
  end

  def externally_hosted?
    @page.externally_hosted
  end

  def formatted_publish_time
    "#{date_params[:publish_time_month]} #{date_params[:publish_time_day]}, #{date_params[:publish_time_year]} #{date_params[:publish_time_hour]}:#{date_params[:publish_time_minute]} #{-date_params[:publish_time_zone].to_i}".to_datetime
  end
end
