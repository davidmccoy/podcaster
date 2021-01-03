# polymorphic class that uses delegated types to support multiple post types
class Post < ApplicationRecord
  # NOTE: this scope and the `publish_time`` attribute are duplicated from the postable models
  # since it is difficult to delegate a scope to a polymorphic association. something like
  # joins(:postable).merge(Postable.published) won't work since `Postable` isn't an actual class.
  scope :published, -> { where('publish_time < ?', Time.now).order(publish_time: :desc) }

  delegated_type :postable, types: %w[ AudioPost TextPost ]
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
