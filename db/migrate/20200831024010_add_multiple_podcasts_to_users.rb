class AddMultiplePodcastsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :multiple_podcasts, :boolean, default: false
  end
end
