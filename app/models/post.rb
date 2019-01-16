# polymorphic class allowing for multiple post types
class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  belongs_to :page
end
