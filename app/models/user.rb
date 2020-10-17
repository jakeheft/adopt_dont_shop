class User < ApplicationRecord
  has_many :reviews
  has_many :shelters, through: :reviews
  has_many :applications
  # has_many :pets, through: :applications
end
