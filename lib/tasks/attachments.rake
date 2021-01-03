namespace :attachments do
  desc 'migrates to new audio post class'

  task migrate_to_audio_post: :environment do
    attachments = Attachment.where(attachable_type: "PodcastEpisode")
    attachments.find_each do |attachment|
      attachment.update(attachable_type: "AudioPost")
    end
  end
end
