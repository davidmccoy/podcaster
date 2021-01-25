class AddParamsToDownloads < ActiveRecord::Migration[6.1]
  def change
    add_column :downloads, :params, :jsonb, null: false, default: {}
  end
end
