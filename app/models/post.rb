class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :likes
  has_many :postcats
  has_many :categories, through: :postcats
end
