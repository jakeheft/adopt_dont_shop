class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
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
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.needed_pets?
      redirect_to "/shelters/#{shelter.id}", notice: "This shelter cannot be deleted. Where would the puppies go?!"
    else
      shelter.destroy_associated_objects
      shelter.destroy
      redirect_to '/shelters'
    end
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
