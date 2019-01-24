class CreateFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string     :type, null: false
      t.references :attachable, polymorphic: true, index: true
      t.text       :file_data
      t.integer    :label
      t.timestamps
    end

    add_index :attachments, :label
  end
end
