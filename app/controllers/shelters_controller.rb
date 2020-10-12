class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new

  end

  def create
    shelter = Shelter.new({
      name: params[:shelter_name],
      address: params[:shelter_address],
      city: params[:shelter_city],
      state: params[:shelter_state],
      zip: params[:shelter_zip]
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
      name: params[:shelter_name],
      address: params[:shelter_address],
      city: params[:shelter_city],
      state: params[:shelter_state],
      zip: params[:shelter_zip]
      })
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end
end
