class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  validates :title, :content, :location, presence: true

  scope :popular, -> {order('likes_count desc')}
  scope :newest, -> {order('created_at desc')}
  scope :find_by_category, lambda {|category_id| where(['category_id = ?', category_id]).limit(20)}
  scope :find_by_location, lambda {|location_id| where(['location_id = ?', location_id]).limit(20)}
  scope :find_since_date, lambda {|created_at| where(['created_at > ?', created_at]).limit(20)}
  
  @@finders = {
    'Since'=>:find_since_date,
    'Location'=>:find_by_location,
    'Category'=>:find_by_category,
  }
  @@sorters = {
    'Likes'=>:popular,
    'Newest'=>:newest
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

  def category_name=(category)
    self.category = Category.find_or_create_by(name: category)
  end

  def category_name
    self.category ? self.category.name : nil
  end

end
