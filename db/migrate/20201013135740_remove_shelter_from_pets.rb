class RemoveShelterFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :shelter, :string
    remove_column :pets, :shelter_name, :string
  end
end
