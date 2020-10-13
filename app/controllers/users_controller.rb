class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new

  end

  def create
    user = User.create({
      name: params[:user_name],
      address: params[:user_address],
      city: params[:user_city],
      state: params[:user_state],
      zip: params[:user_zip]
      })
    redirect_to "/users/#{user.id}"
    @users = User.all
  end
end
