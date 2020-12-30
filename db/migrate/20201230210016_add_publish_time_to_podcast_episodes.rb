class AddPublishTimeToPodcastEpisodes < ActiveRecord::Migration[6.1]
  def change
    add_column :podcast_episodes, :publish_time, :datetime
  end
end
