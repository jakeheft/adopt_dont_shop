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
    shelter.pets.create(shelter_pets_params.merge({status: "Adoptable"}))
      redirect_to "/shelters/#{shelter.id}/pets"
  end

  private
  def shelter_pets_params
    params.permit(:image, :name.downcase, :description, :age, :sex)
  end
end
