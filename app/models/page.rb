# a page is the home where users publish posts
class Page < ApplicationRecord
  belongs_to :user, optional: true
  has_many :posts
  has_many :podcast_episodes, through: :posts, source: :postable, source_type: 'PodcastEpisode'

  validates :slug, uniqueness: true, allow_blank: true

  after_commit :set_slug, on: [:create, :update]

  def to_param
    slug
  end

  private

  # ensure the slug is unique before committing 
  def set_slug
    slug = nil
    index = 0
    loop do
      slug = name.parameterize 
      slug = slug + "-#{index}" unless index == 0
      break unless Page.where(slug: slug).exists?
      index += 1
    end

    update_column(:slug, slug)
  end
end
