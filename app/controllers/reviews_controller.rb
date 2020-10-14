class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    @shelter.reviews.create({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image],
      username: params[:username]
      })
  end
end
