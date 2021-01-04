class Download < ApplicationRecord
  belongs_to :audio_post
  has_one :page, through: :audio_post
end
