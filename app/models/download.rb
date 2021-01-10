class Download < SecondaryRecord
  belongs_to :audio_post
  # page should be a has one through audio_post but pages are stored in a different database
  # and rails doesn't support joins accross databases yet
  belongs_to :page
end
