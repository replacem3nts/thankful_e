class Category < ApplicationRecord
    has_many :postcats
    has_many :posts, through: :postcats
end
