class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
  end

  # def update
  #   application = Application.find(params[:application_id])
  #   application.update(
  #     status: "Approved"
  #   )
  # end

  # private
  # def admin_application_params
  #   params.permit(:application_id)
  # end
end
