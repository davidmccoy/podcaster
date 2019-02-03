namespace :audio do
  desc 'Migrates audio files from external services to s3'

  task migrate_to_s3: :environment do
    podcast_episodes = PodcastEpisode.where(file_migrated: false)
    podcast_episodes.find_each do |podcast_episode|
      MigrateAudioToS3Worker.perform_async(podcast_episode.id)
    end
  end

  task add_labels_to_podcast_episodes: :environment do
    Attachment.find_each do |attachment|
      attachment.update(label: 'podcast_episode')
    end
  end
end
