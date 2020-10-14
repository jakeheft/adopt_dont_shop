class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    users = User.all
    current_user = users.find do |user|
      user.name == params[:username]
    end
    @review = Review.create({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image],
      shelter_id: params[:shelter_id],
      user: current_user
      })
      redirect_to "/shelters/#{@review.shelter_id}"
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image],
      shelter_id: params[:shelter_id],
      user: User.where(name: params[:username])[0]
    })
    redirect_to "/shelters/#{review.shelter_id}"
  end
end
