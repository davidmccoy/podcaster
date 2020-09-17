class AddImportedToPodcastEpisodes < ActiveRecord::Migration[6.0]
  def change
    add_column :podcast_episodes, :imported, :boolean, default: false
  end
end
