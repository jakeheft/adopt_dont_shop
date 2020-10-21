class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.application_needed?
      redirect_to "/pets/#{pet.id}", notice: "This pet cannot be deleted because it is in the process of adoption"
    else
      pet.destroy_pet_apps
      pet.destroy
      redirect_to "/pets"
    end
  end

  private
  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end
end
