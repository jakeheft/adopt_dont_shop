class User < ApplicationRecord
  has_many :reviews
  has_many :shelters, through: :reviews
  has_many :applications
  # has_many :pets, through: :applications

  def full_address
    "#{self.address}, #{self.city}, #{self.state}, #{self.zip}"
  end
end
