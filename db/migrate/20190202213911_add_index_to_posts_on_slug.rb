class AddIndexToPostsOnSlug < ActiveRecord::Migration[5.1]
  def change
    add_index :posts, :slug
  end
end
