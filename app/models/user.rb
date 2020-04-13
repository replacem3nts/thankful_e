class User < ApplicationRecord
  has_secure_password
  belongs_to :location
  has_many :posts
  has_many :likes
end
