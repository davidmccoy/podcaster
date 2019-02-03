class AddPublishTimeToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :publish_time, :datetime
  end
end
