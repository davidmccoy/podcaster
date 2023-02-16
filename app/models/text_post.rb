# polymorphic class allowing for multiple post types
class TextPost < ApplicationRecord
  before_save :sanitize_body

  # NOTE: we need to specify `text_posts.publish_time` in order to avoid ambiguous
  # column reference errors
  scope :published, -> { where('text_posts.publish_time < ?', Time.now).order(publish_time: :desc) }

  has_one :post, as: :postable
  has_one :page, through: :post

  has_rich_text :content

  private

  def sanitize_body
    self.body = Post::Sanitizer.new.sanitize(body)
  end
end
