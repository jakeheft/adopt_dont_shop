class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
  end

  def create
    PetApplication.create(
      pet_id: params[:pet_id],
      application_id: params[:application_id],
      pet_application_status: "Pending"
    )
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    pet_app = PetApplication.retrieve(params[:pet_id], params[:application_id])
    if params[:response] == "reject"
      pet_app.update(pet_application_status: "Rejected")
    else
      pet_app.update(pet_application_status: "Approved")
    end

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end
