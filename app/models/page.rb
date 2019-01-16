# a page is the home where users publish posts
class Page < ApplicationRecord
  belongs_to :user, optional: true
  has_many :posts
  has_many :podcast_episodes, through: :posts, source: :postable, source_type: 'PodcastEpisode'

  after_commit :set_slug, on: [:create, :update]

  def to_param
    slug
  end

  private

  def set_slug
    update_column(:slug, name.parameterize)
  end
end
