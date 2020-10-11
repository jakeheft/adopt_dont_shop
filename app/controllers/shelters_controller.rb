class SheltersController < ApplicationController
  # this will change after I create a shelter object and show.html.erb will be setup like: shelter.id[name], shelter.id[address], etc.
  def index
    @shelters = Shelter.all
  end

  def new

  end

  def create
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
    })
    shelter.save
    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  def pets
    @shelter = Shelter.find(params[:id])
    @pets = Pet.all
  end

  def new_pet
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create_pet
    shelter = Shelter.find(params[:shelter_id])
    pet = Pet.create({
      image: params[:pet_image],
      name: params[:pet_name],
      description: params[:pet_description],
      age: params[:pet_age],
      sex: params[:pet_sex],
      shelter: shelter,
      status: "Adoptable",
      shelter_id: params[:shelter_id]
      })
      pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
  end
end
