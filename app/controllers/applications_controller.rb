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
    if application.id == nil
      redirect_to "/applications/new", notice: "Please enter a user name that matches an existing user"
    else
      redirect_to "/applications/#{application.id}"
    end
  end
end
