# Migrates audio from unknown external services to s3
class MigrateAudioToS3Worker
  include Sidekiq::Worker

  def perform(podcast_episode_id)
    podcast_episode = PodcastEpisode.find(podcast_episode_id)

    audio = Audio.new(
      attachable_type: 'PodcastEpisode',
      attachable_id: podcast_episode.id
    )
    audio.file_remote_url = podcast_episode.external_file_url

    # Use the cache prefix because file gets copied afters save
    # S3_PODCASTS.object("cache/#{audio.file.id}").exists? might work, too
    unless audio.file.exists?
      raise 'audio didn\'t migrate'
    end

    podcast_episode.update(file_migrated: true) if audio.save
  end
end
