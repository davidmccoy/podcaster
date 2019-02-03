class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  LABELS = {
    podcast_episode: 0
  }.freeze

  enum label: LABELS
end
