class AddDescriptionToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :description, :text
  end
end
