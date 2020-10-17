class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:app_id])
  end

  def new
  end

  def create
    application = Application.create(
      user: User.where(name: params[:user_name])[0],
      status: "In Progress"
    )
    redirect_to "/applications/#{application.id}"
  end
end
