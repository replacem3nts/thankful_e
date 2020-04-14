class User < ApplicationRecord
  has_secure_password
  belongs_to :location
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
end
