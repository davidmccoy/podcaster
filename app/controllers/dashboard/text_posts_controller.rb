# Only accessible by page admins
class Dashboard::TextPostsController < ApplicationController
  before_action :set_page
  before_action :authorize_page
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = @page.posts.where(postable_type: "TextPost")
              .order(publish_time: :desc)
              .paginate(page: params[:page], per_page: 20)
  end

  def new
    @post = @page.posts.new(postable_type: "TextPost")
  end

  def create
    @post = Post.new(
      post_params.merge(
        page_id: @page.id,
        postable_type: "TextPost",
        publish_time: formatted_publish_time,
        postable_attributes: post_params[:postable_attributes].merge(publish_time: formatted_publish_time)
      )
    )

    if @post.save
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
      flash[:notice] = 'Successfully updated post.'
    else
      flash[:alert] = 'Failed to update post.'
    end

    redirect_to edit_page_dashboard_text_post_path(@page, @post)
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Successfully deleted post.'
      redirect_to page_dashboard_text_posts_path(@page) and return
    else
      flash[:alert] = 'Failed to delete post.'
      redirect_to edit_page_dashboard_text_post_path(@page, @post) and return
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

  def formatted_publish_time
    "#{date_params[:publish_time_month]} #{date_params[:publish_time_day]}, #{date_params[:publish_time_year]} #{date_params[:publish_time_hour]}:#{date_params[:publish_time_minute]} #{-date_params[:publish_time_zone].to_i}".to_datetime
  end
end
