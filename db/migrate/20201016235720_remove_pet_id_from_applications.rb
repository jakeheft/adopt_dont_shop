class RemovePetIdFromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_reference :applications, :pet, foreign_key: true
  end
end
