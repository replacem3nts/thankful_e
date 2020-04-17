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

end


