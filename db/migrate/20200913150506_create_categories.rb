class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :category_pages do |t|
      t.belongs_to :page
      t.belongs_to :category
    end
  end
end
