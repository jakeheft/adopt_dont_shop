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
      image: params[:image],
      name: params[:name].downcase,
      description: params[:description],
      age: params[:age],
      sex: params[:sex],
      status: "Adoptable",
      })
      redirect_to "/shelters/#{shelter.id}/pets"
  end
end
