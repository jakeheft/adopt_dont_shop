class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :image, :name, :age, :sex

  def self.find_pets(pet_name)
    Pet.where("name like ?", "%#{pet_name}%")
  end

  def status_anywhere?(status)
    self.applications.where(status: status) != []
  end

  def application_needed?
    status_anywhere?("Approved") || status_anywhere?("Pending")
  end

  def destroy_pet_apps
    pet_applications.each do |app|
      app.destroy
    end
  end
end
