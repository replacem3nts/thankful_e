class User < ApplicationRecord
  belongs_to :location
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_secure_password
  validates :username, :email, presence: true
  validates :password, confirmation: true
end
