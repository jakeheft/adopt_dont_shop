class ChangeRatingToBeIntegerInReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :rating, 'integer USING CAST(rating AS integer)'
  end
end
