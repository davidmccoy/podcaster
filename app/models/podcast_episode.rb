# polymorphic class allowing for multiple post types
class PodcastEpisode < ApplicationRecord
  has_one :post, as: :postable
  has_one :page, through: :post
  has_many :attachments, as: :attachable

  def audio
    Audio.where(attachable_type: 'PodcastEpisode', attachable_id: id)
  end
end
