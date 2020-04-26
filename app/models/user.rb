class User < ApplicationRecord
  belongs_to :location, optional: true
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_one_attached :avatar
  has_secure_password
  validates :password, confirmation: true
  validates :username, :email, presence: true, uniqueness: true

  before_create do
    self.avatar.attach(io: File.open('app/assets/images/no_avatar.png'), filename: 'no_avatar.png')
  end

  def liked_post?(post)
    liked_posts.include?(post)
  end

  def thirty_day_array
    my_post_dates = posts.map {|p| p.created_at.strftime("%m/%d/%y")}
    my_post_dates.uniq

    dates = [[],[],[]]
    i = 29
    while i >= 0 do
      if i >= 20
        dates[0] << (Time.now.utc.to_date - i).strftime("%m/%d/%y")
      elsif i >= 10
        dates[1] << (Time.now.utc.to_date - i).strftime("%m/%d/%y")
      else
        dates[2] << (Time.now.utc.to_date - i).strftime("%m/%d/%y")
      end
      i -=1
    end

    post_calendar = []
    dates.each do |row|
      post_calendar << row.map {|date| my_post_dates.include?(date) ? "🙏" : "⋅"}
    end

    post_calendar
  end


end


