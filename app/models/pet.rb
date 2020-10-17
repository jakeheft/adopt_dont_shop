class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  # has_many :users, through: :applications

  validates_presence_of :image, :name, :age, :sex
end
