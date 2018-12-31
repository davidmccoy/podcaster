class EpisodeTagReaderWorker
  require 'open-uri'
  require 'id3tag'
  include Sidekiq::Worker

  def perform(episode_id)
    episode = Episode.find_by_id(episode_id)
    episode_file = open(episode.blubrry_file_url) if episode
    episode_tags = ID3Tag.read(episode_file) if episode_file

    episode.update(
      title: episode_tags.title,
      artist: episode_tags.artist
    )
  end
end