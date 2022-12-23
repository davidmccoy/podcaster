class AddByteRangeToDownloads < ActiveRecord::Migration[6.1]
  def change
    add_column :downloads, :byte_range, :string
  end
end
