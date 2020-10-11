class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:id])
    @pets = Pet.all
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = Pet.create({
      image: params[:pet_image],
      name: params[:pet_name],
      description: params[:pet_description],
      age: params[:pet_age],
      sex: params[:pet_sex],
      shelter_name: shelter.name,
      shelter: shelter,
      status: "Adoptable",
      shelter_id: params[:shelter_id]
      })
      pet.save
      # require "pry"; binding.pry
      redirect_to "/shelters/#{shelter.id}/pets"
  end
end
