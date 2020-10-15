class RemoveShelterIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :shelter_id, :bigint
    remove_column :reviews, :user_id, :bigint
  end
end
