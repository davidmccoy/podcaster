# polymorphic class allowing for multiple post types
class PodcastEpisode < ApplicationRecord
  has_one :post, as: :postable
  has_one :page, through: :post
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :audio, -> { where(attachments: { type: 'Audio' }) },
           foreign_key: :attachable_id

  has_rich_text :content

  accepts_nested_attributes_for :attachments

  def podcast_episode
    attachments.find_by(label: 'podcast_episode')
  end
end
