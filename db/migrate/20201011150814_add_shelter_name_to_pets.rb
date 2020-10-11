class AddShelterNameToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :shelter_name, :string
  end
end
