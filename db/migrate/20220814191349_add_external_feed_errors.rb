class AddExternalFeedErrors < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :external_rss_error, :boolean, default: false
    add_column :pages, :external_rss_error_message, :string
  end
end
