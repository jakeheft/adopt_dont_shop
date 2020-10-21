class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :image, :name, :age, :sex

  def self.find_pets(pet_name)
    Pet.where("name like ?", "%#{pet_name}%")
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

  def destroy_pet_apps
    pet_applications.each do |app|
      app.destroy
    end
  end
end
