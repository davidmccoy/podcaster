# polymorphic class allowing for multiple post types
class BlogPost < ApplicationRecord
  # NOTE: we need to specify `podcast_episodes.publish_time` in order to avoid ambiguous
  # column reference errors
  scope :published, -> { where('blog_posts.publish_time < ?', Time.now).order(publish_time: :desc) }

  has_one :post, as: :postable
  has_one :page, through: :post

  has_rich_text :content
end
