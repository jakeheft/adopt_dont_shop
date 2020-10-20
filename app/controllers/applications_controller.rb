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

  def update
    application = Application.find(params[:app_id])
    if empty_description?
      redirect_to "/applications/#{application.id}", notice: "You must fill out a description to complete a submission."
    else
      application.update(
        description: params[:description],
        status: "Pending"
      )
      redirect_to "/applications/#{application.id}"
    end
  end

  def empty_description?
    params[:description] == "" || params[:description] == nil
  end
end
