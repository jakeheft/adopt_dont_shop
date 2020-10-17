class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:app_id])
  end

  def new
  end
end
