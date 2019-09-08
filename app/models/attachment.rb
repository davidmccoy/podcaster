class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  LABELS = {
    podcast_episode: 0,
    logo: 1
  }.freeze

  enum label: LABELS
end
