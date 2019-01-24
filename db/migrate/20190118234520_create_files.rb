class CreateFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.integer    :label
      t.references :attachable, polymorphic: true, index: true
      t.text       :file_data
      t.timestamps
    end

    add_index :attachments, :label
  end
end
