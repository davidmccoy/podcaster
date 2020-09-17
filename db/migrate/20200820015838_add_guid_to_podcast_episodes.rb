class AddGuidToPodcastEpisodes < ActiveRecord::Migration[6.0]
  def change
    add_column :podcast_episodes, :guid, :text

    add_index :podcast_episodes, :guid
  end
end
