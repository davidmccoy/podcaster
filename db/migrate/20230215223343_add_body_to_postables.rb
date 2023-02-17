class AddBodyToPostables < ActiveRecord::Migration[7.0]
  def change
    add_column :audio_posts, :body, :text
    add_column :text_posts, :body, :text
  end
end
