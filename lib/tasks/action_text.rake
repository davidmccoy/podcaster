namespace :action_text do
  desc 'migrates to new audio post class'

  task migrate_to_audio_post: :environment do
    texts = ActionText::RichText.where(record_type: "PodcastEpisode")
    texts.find_each do |attachment|
      attachment.update(record_type: "AudioPost")
    end
  end
end
