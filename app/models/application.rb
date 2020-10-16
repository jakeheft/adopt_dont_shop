class Application < ApplicationRecord
  belongs_to :pet
  belongs_to :user

  validates_presence_of :user_id, :pet_id, :description, :status

end
