# polymorphic class that uses delegated types to support multiple post types
class Post < ApplicationRecord
  # we have to explicitly say `posts.publish_time` or the column reference will be ambiguous
  # and fail when merging this scope in the postable models.
  scope :published, -> { where('posts.publish_time < ?', Time.now).order(publish_time: :desc) }

  delegated_type :postable, types: %w[ PodcastEpisode ]
  belongs_to :page

  accepts_nested_attributes_for :postable

  before_commit :ensure_slug, on: [:create, :update]

  def to_param
    slug
  end

  def build_postable(params)
    self.postable = postable_type.constantize.new(params)
  end

  private

  def ensure_slug
    return true if slug

    if postable
      self.slug = "#{postable.title.parameterize}-#{SecureRandom.hex(5)}"
    else
      self.slug = "#{SecureRandom.hex(5)}"
    end
  end
end
