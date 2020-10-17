class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  # has_many :users, through: :applications

  validates_presence_of :image, :name, :age, :sex

  def self.find_pets(pet_name)
    # pet = Pet.where(name: LIKE "%#{pet_name.downcase}%")
    pets = Pet.all
    pets.find_all do |pet|
      name.include?(pet_name)
    end
  end
end
