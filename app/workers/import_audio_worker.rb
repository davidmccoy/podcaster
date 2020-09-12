# Imports and attaches audio files for podcast episodes from an RSS feed
class ImportAudioWorker
  include Sidekiq::Worker

  def perform(podcast_episode_id, url)
    podcast_episode = PodcastEpisode.find(podcast_episode_id)

    Audio.new.tap do |a|
      a.attachable_type = 'PodcastEpisode'
      a.attachable_id = podcast_episode_id
      a.label = 'podcast_episode'
      a.file_remote_url = url
      a.save!
    end
  rescue => e
    p "****** #{e.message} ******"
    podcast_episode.update(import_errors: e.message)
  end
end
