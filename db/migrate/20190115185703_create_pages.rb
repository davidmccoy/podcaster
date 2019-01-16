class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.string  :name, null: false
      t.timestamps
    end

    add_index :pages, :user_id
  end
end
