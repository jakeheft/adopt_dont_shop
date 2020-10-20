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
    pets.any? do |pet|
      app_statuses = pet.applications.map do |application|
        application.status
      end
      app_statuses.include?("Pending" || "Approved")
    end
  end

  def destroy_associated_objects
    pets.each do |pet|
      # move the next each block into pet model?
      pet.pet_applications.each do |app|
        app.destroy
      end
      pet.destroy
    end
    reviews.each do |review|
      review.destroy
    end
  end
end
