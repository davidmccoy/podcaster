class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer    :page_id
      t.references :postable, polymorphic: true, index: true
      t.timestamps
    end

    add_index :posts, :page_id
  end
end
