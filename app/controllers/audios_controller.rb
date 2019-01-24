#
class AudiosController < ApplicationController
  before_action :set_page
  before_action :set_post

  def new
    @audio = Audio.new
  end

  def create
    @audio = Audio.create(audio_params.merge({
      attachable_type: @post.postable.class.to_s,
      attachable_id: @post.postable.id
    }))
  end

  private

  def audio_params
    params.require(:audio).permit(:file)
  end
end
