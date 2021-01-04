#
class AudiosController < ApplicationController
  before_action :set_page
  before_action :set_post
  before_action :set_audio, only: [:show, :link]

  # TODO: i don't think these are used any more
  # def new
  #   @audio = Audio.new
  # end

  # def create
  #   @audio = Audio.create(audio_params.merge({
  #     attachable_type: @post.postable.class.to_s,
  #     attachable_id: @post.postable.id
  #   }))
  # end

  def show
    # TODO: this also triggers when "Save As..." is clicked, even if the download
    # is never initiated.
    record_download
    update_download_count
    redirect_to @audio.url
  end

  # TODO: i don't think these are used any more
  # def link
  #   url = "#{params[:url].gsub('https:/', 'https://')}.#{params[:format]}"

  #   if url == @audio.url
  #     update_download_count
  #     redirect_to @audio.url and return
  #   else
  #     redirect_to root_path and return
  #   end
  # end

  def embedded_play
    if play_params.permitted? && play_params[:play] == 'true'
      record_download
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

  def feed_params
    params.permit(:source)
  end

  def record_download
    @download = Download.create(
      audio_post_id: @post.id,
      user_id: current_user&.id,
      ip: request.ip,
      user_agent: request.user_agent,
      referrer: request.referrer,
      referring_domain: request.origin,
      feed_source: feed_params[:source],
    )
  end

  def update_download_count
    ProcessDownloadWorker.perform_async(@download.id)
  end
end
