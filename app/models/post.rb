class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :likes, dependent: :destroy
  has_many :postcats, dependent: :destroy
  has_many :categories, through: :postcats
  has_many :likers, through: :likes, source: :user
  accepts_nested_attributes_for :categories

  scope :sort_by_likes, -> {order('likes_count desc')}
  scope :sort_by_newest, -> {order('created_at desc')}
  scope :find_by_category, lambda {|category_id| joins(:postcats).where(['category_id = ?', category_id])}
  scope :find_by_location, lambda {|location_id| where(['location_id = ?', location_id])}
  scope :find_since_date, lambda {|created_at| where(['created_at > ?', created_at])}
  
  @@finders = {
    'Since'=>:find_since_date,
    'Location'=>:find_by_location,
    'Category'=>:find_by_category,
  }
  @@sorters = {
    'Likes'=>:sort_by_likes,
    'Newest'=>:sort_by_newest
  }

  def self.check_dates
    d = DateTime.now
    [
      ["The Past Week", (d - 7)],
      ["The Past Two Weeks", (d - 14)],
      ["The Past Month", (d << 1)],
      ["The Past 3 Months", (d << 3)]
    ]
  end
  # Using named scopes stored in class vars above, takes arguments (find by some type, arg for that finder, sort method) and queries the db for those results.
  def self.record_builder(finder='Since', value=Date.today, sorter='Likes')
    Post.send(@@finders[finder], value).send(@@sorters[sorter])
  end

  def category_attributes=(cat_attribs)
    cat_attribs.values.each do |cat_attrib|
      category = Category.find_or_create_by(cat_attrib)
      self.categories << category
    end
  end

  def post_like(user)
    likes.where(user_id: user.id).first
  end

  def liked?(user)
    !!post_like(user)
  end

end
