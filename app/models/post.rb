class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :likes, dependent: :destroy
  has_many :postcats, dependent: :destroy
  has_many :categories, through: :postcats
  scope :sort_likes, -> {order('likes_count desc')}
  accepts_nested_attributes_for :categories
  
  def category_attributes=(cat_attribs)
    cat_attribs.values.each do |cat_attrib|
      category = Category.find_or_create_by(cat_attrib)
      self.categories << category
    end
  end
end
