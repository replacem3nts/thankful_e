class Location < ApplicationRecord
    has_many :posts
    has_many :users
end
