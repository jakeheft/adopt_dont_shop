class AddDescriptionToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :description, :string
    add_column :applications, :status, :string
  end
end
