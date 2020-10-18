class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :user_id, :status

  def status_check
    statuses = pet_applications.map do |pet_app|
      pet_app.pet_application_status
    end
    if statuses.include?("Rejected")
      self.status = "Rejected"
    elsif statuses.include?("Pending")
      self.status = "Pending"
    else
      self.status = "Approved"
    end
  end
end
