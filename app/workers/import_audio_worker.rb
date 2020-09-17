# Imports and attaches audio files for podcast episodes from an RSS feed
class ImportAudioWorker
  include Sidekiq::Worker

  def perform(podcast_episode_id, url)
    podcast_episode = PodcastEpisode.find(podcast_episode_id)
    file_location = ::RedirectFollower.new(url).resolve.url

    Audio.new.tap do |a|
      a.attachable_type = 'PodcastEpisode'
      a.attachable_id = podcast_episode_id
      a.label = 'podcast_episode'
      a.file_remote_url = file_location
      a.save!
    end
  rescue => e
    podcast_episode.update(import_errors: e.message)
  end
end
