class AddDownlaodColumnsToPodcastEpisodes < ActiveRecord::Migration[6.0]
  def change
    rename_column :podcast_episodes, :downloads, :total_downloads
    add_column :podcast_episodes, :individual_downloads, :bigint, default: 0
    add_column :podcast_episodes, :aggregate_feed_downloads, :bigint, default: 0
  end
end
