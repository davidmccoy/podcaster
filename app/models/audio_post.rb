# polymorphic class allowing for multiple post types
class AudioPost < ApplicationRecord
  # NOTE: we need to specify `audio_posts.publish_time` in order to avoid ambiguous
  # column reference errors
  scope :published, -> { where('audio_posts.publish_time < ?', Time.now).order(publish_time: :desc) }

  has_one :post, as: :postable
  has_one :page, through: :post
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :audio, -> { where(attachments: { type: 'Audio' }) },
           foreign_key: :attachable_id

  has_rich_text :content

  accepts_nested_attributes_for :attachments

  # TODO: this is a really bad name
  def podcast_episode
    attachments.find_by(label: 'podcast_episode')
  end
end
