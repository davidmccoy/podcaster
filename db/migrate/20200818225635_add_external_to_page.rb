class AddExternalToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :externally_hosted, :boolean, default: false
    add_column :pages, :external_rss, :text
  end
end
