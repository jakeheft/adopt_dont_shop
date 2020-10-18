class AddPetApplicationStatusToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :pet_application_status, :string
  end
end
