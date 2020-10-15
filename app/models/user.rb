class User < ApplicationRecord
  has_many :reviews
  has_many :shelters, through: :reviews
end
