class AddDownloadsToPodcastEpisodes < ActiveRecord::Migration[6.0]
  def change
    add_column :podcast_episodes, :downloads, :bigint, default: 0
  end
end
