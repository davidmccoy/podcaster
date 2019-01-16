class CreatePodcastEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :podcast_episodes do |t|
      t.string   :title, null: false
      t.text     :description
      t.string   :filename
      t.string   :external_file_url
      t.string   :external_date
      t.integer  :external_unique_downloads
      t.integer  :external_total_downloads
      t.datetime :date
      t.boolean  :file_migrated, default: false
      t.timestamps
    end

    add_index :podcast_episodes, :file_migrated
  end
end
