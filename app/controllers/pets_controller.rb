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
    pet.update({
      image: params[:pet_image],
      name: params[:pet_name],
      description: params[:pet_description],
      age: params[:pet_age],
      sex: params[:pet_sex]
    })
    pet.save
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
end
