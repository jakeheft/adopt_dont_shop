class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :user_id, :status

  def contain_this?(status)
    id = self.id
    PetApplication.where(application_id: id).where(pet_application_status: status) != []
  end

  def status_check
    if contain_this?("Rejected")
      self.update(status: "Rejected")
      self.status
    elsif contain_this?("Pending")
      self.update(status: "Pending")
      self.status
    else
      self.update(status: "Approved")
      self.status
    end
  end
end
