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
      self.update(status: "Rejected")
      self.status
    elsif statuses.include?("Pending")
      self.update(status: "Pending")
      self.status
    else
      self.update(status: "Approved")
      self.status
      # redirect_to "admin/applications/#{self.id}"
    end
  end
end
