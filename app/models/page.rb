# a page is the home where users publish posts
class Page < ApplicationRecord
  belongs_to :user, optional: true
  has_many :posts
end
