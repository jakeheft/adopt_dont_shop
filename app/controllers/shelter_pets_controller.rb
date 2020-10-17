class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:id])
    @pets = Pet.all ## don't use this, but rather call @shelter.pets in your views
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.pets.create({
      image: params[:pet_image],
      name: params[:pet_name].capitalize,
      description: params[:pet_description],
      age: params[:pet_age],
      sex: params[:pet_sex],
      status: "Adoptable",
      })
      redirect_to "/shelters/#{shelter.id}/pets"
  end
end
