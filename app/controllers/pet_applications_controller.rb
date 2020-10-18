class PetApplicationsController < ApplicationController
  def create
    PetApplication.create(
      pet_id: params[:pet_id],
      application_id: params[:application_id],
      pet_application_status: "Pending"
    )
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    pet_app = PetApplication.where(application_id: params[:application_id]).where(pet_id: params[:pet_id])

    pet_app.update(pet_application_status: "Approved")

    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  # private
  # def pet_app_params
  #   params.permit(:pet_id, :application_id)
  # end
end
