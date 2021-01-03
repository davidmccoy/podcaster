class ChangePodcastEpisodesToAudioPosts < ActiveRecord::Migration[6.1]
  def change
    rename_table :podcast_episodes, :audio_posts
  end
end
