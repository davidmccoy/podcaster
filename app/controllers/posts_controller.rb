#
class PostsController < ApplicationController
  before_action :set_page
  before_action :set_post
  before_action :authorize_post, except: [:show]

  def show; end

  def new; end

  def create
    @post = Post.new(post_params.merge(page_id: @page.id))

    if @post.save
      @audio = Audio.create(attachment_params[:attachment].merge(
        attachable_type: @post.postable.class,
        attachable_id: @post.postable.id
      ))
      flash[:notice] = 'Successfully created your post!'
      redirect_to edit_page_post_path(@page, @post) and return
    else
      flash[:alert] = 'You\'re missing a few things.'
      render :new and return
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Successfully updated post.'
    else
      flash[:alert] = 'Failed to update post.'
    end

    redirect_to edit_page_post_path(@page, @post)
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Successfully deleted post.'
      redirect_to page_path(@page) and return
    else
      flash[:alert] = 'Failed to delete post.'
      redirect_to edit_page_post_path(@page, @post) and return
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
              :title,
              :description
            ]
          )
  end

  def attachment_params
    params.require(:post).permit(attachment: [:file])
  end
end
