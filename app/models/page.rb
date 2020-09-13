# a page is the home where users publish posts
class Page < ApplicationRecord
  belongs_to :user, optional: true
  has_many :posts, dependent: :destroy
  has_one :latest_post, -> { where('publish_time < ?', Time.now).order(publish_time: :desc) }, class_name: 'Post'
  has_many :podcast_episodes, through: :posts, source: :postable, source_type: 'PodcastEpisode'
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :images, -> { where(attachments: { type: 'Image' }) }, foreign_key: :attachable_id
  has_one :logo, -> { where(attachments: { type: 'Logo' }) }, foreign_key: :attachable_id
  has_many :category_pages
  has_many :categories, through: :category_pages

  has_rich_text :description

  validates :slug, uniqueness: true, allow_blank: true

  after_commit :set_slug, on: [:create, :update]

  accepts_nested_attributes_for :attachments

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
      # 'new' is a reserved word since we use the slug as a parameter
      slug = slug + "-#{index}" if (slug == 'new' || index != 0)
      break unless Page.where(slug: slug).exists?
      index += 1
    end

    update_column(:slug, slug)
  end
end
