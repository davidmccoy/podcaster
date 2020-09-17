# pages can be categorized by topic, be it format (Limited, Standard, Modern) or something
# like News or Arena.
class Category < ApplicationRecord
  has_many :category_pages
  has_many :pages, through: :category_pages
end
