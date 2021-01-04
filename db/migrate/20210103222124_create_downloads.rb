class CreateDownloads < ActiveRecord::Migration[6.1]
  def change
    create_table :downloads do |t|
      t.references :audio_post
      t.references :user
      t.string :feed_source

      # standard
      t.string :ip
      t.text :user_agent
      t.text :referrer
      t.string :referring_domain

      # technology
      t.string :browser
      t.string :os
      t.string :device_type

      # location
      t.string :country
      t.string :region
      t.string :city
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
