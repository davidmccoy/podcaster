# polymorphic class allowing for multiple post types
class PodcastEpisode < ApplicationRecord
  has_one :post, as: :postable
  has_one :page, through: :post
end
