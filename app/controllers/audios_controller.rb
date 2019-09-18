#
class AudiosController < ApplicationController
  before_action :set_page
  before_action :set_post
  before_action :set_audio, only: [:show, :link]

  def new
    @audio = Audio.new
  end

  def create
    @audio = Audio.create(audio_params.merge({
      attachable_type: @post.postable.class.to_s,
      attachable_id: @post.postable.id
    }))
  end

  def show
    # TODO: this also triggers when "Save As..." is clicked, even if the download
    # is never initiated.
    update_download_count
    redirect_to @audio.url
  end

  def link
    url = "#{params[:url].gsub('https:/', 'https://')}.#{params[:format]}"

    if url == @audio.url
      update_download_count
      redirect_to @audio.url and return
    else
      redirect_to root_path and return
    end
  end

  def record_play
    if play_params.permitted? && play_params[:play] == 'true'
      update_download_count
    end

    head :ok
  end

  private

  def audio_params
    params.require(:audio).permit(:file)
  end

  def play_params
    params.require(:audio).permit(:id, :play)
  end

  def update_download_count
    UpdateDownloadCountWorker.perform_async(@post.id)
  end
end
