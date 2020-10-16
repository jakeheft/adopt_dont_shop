class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :applications
  has_many :users, through: :applications

  validates_presence_of :image, :name, :age, :sex
end
