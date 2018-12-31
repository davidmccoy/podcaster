class CreateEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :episodes do |t|
      t.integer  :podcast_id
      t.string   :blubrry_filename
      t.string   :blubrry_file_url
      t.string   :blubrry_date
      t.integer  :blubrry_unique_downloads
      t.integer  :blubrry_total_downloads
      t.string   :title
      t.string   :artist
      t.datetime :date
      t.boolean  :file_migrated, default: false
    end

    add_index :episodes, :blubrry_filename
    add_index :episodes, :date
    add_index :episodes, :podcast_id
    add_index :episodes, :file_migrated
  end
end
