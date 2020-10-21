class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  has_many :users, through: :reviews

  validates_presence_of :name, :address, :city, :state, :zip

  def total_pets
    pets.calculate(:count, :all)
  end

  def average_reviews
    Review.where(shelter_id: id).average(:rating).to_f
  end

  def total_applications
    pets.joins(:applications).select('applications.*').distinct.calculate(:count, :all)
  end

  def needed_pets?
    pets.any? do |pet|
      pet.application_needed?
    end
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
