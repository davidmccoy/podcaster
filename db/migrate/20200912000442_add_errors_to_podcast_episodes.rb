class AddErrorsToPodcastEpisodes < ActiveRecord::Migration[6.0]
  def change
    add_column :podcast_episodes, :import_errors, :text
  end
end
