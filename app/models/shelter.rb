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

  def total_applications # change to active record with (inner) join
    pets.map do |pet|
      pet.applications
    end.uniq.count
  end

  def needed_pets?# change to active record with (inner) join
    app_statuses = []
    pets.any? do |pet|
      pet.applications.each do |application|
        app_statuses << application.status
      end
    end
    app_statuses.include?("Pending") || app_statuses.include?("Approved")
  end

  def destroy_associated_objects
    pets.each do |pet|
      pet.destroy_pet_apps
      pet.destroy
    end
    reviews.each do |review|
      review.destroy
    end
  end
end
