class User < ApplicationRecord
  has_many :reviews
  has_many :shelters, through: :reviews
  has_many :applications

  def full_address
    "#{address}, #{city}, #{state}, #{zip}"
  end
end
