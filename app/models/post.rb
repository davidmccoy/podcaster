# polymorphic class allowing for multiple post types
class Post < ApplicationRecord
  scope :published, -> { where('publish_time < ?', Time.now).order(publish_time: :desc) }

  belongs_to :postable, polymorphic: true, dependent: :destroy
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
