class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  has_many :users, through: :reviews

  validates_presence_of :name, :address, :city, :state, :zip

  def total_pets
    pets.count
  end

  def average_reviews
    total_ratings = reviews.sum { |review| review.rating }
    total_ratings.to_f / reviews.count
  end
end
