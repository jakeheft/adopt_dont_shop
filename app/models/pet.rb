class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  # has_many :users, through: :applications

  validates_presence_of :image, :name, :age, :sex

  def self.find_pets(pet_name)
    Pet.all.find_all do |pet|
      pet.name.downcase.include?(pet_name.downcase)
    end
  end

  def approved_anywhere?
    applications.any? do |application|
      application.status == "Approved"
    end
  end

  def application_needed?
    applications.any? do |application|
      application.status == "Approved" || application.status == "Pending"
    end
  end
end
