class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_presence_of :application_id, :pet_id, :pet_application_status

  def self.retrieve(pet_id, application_id)
    pet_app = PetApplication.where(application_id: application_id).where(pet_id: pet_id)
    pet_app[0]
  end
end
