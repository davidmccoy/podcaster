class CreateBlogPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_posts do |t|
      t.string "title", null: false
      t.datetime "publish_time"
      t.timestamps
    end
  end
end
