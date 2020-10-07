class SheltersController < ApplicationController
  # this will change after I create a shelter object and show.html.erb will be setup like: shelter.id[name], shelter.id[address], etc.
  def index
    @shelters = ["shelter1", "shelter2"]#Shelter.all
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

  # def show
  #   # binding.pry
  #   # @shelter = Shelter.find(params[:id])
  # end
end
