# join table to connect Pages with Categories.
class CategoryPage < ApplicationRecord
  belongs_to :category
  belongs_to :page
end
