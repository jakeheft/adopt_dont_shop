class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @review = Review.create({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image],
      shelter_id: params[:shelter_id],
      user: User.where(name: params[:username])[0]
      })
    if @review.id == nil
      redirect_to "/shelters/#{@review.shelter_id}/reviews/new", notice: "All fields except for image must be filled out."
    else
      redirect_to "/shelters/#{@review.shelter_id}"
    end
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

  def destroy
    Review.find(params[:review_id]).destroy
    redirect_to "/shelters/#{params[:shelter_id]}"
  end
end
