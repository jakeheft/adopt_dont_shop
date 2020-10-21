class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    user = User.where(name: params[:username])[0]
    if user == nil
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/new", notice: "Please enter the name of a valid user"
    else
      @review = user.reviews.create(review_params)
      if @review.id == nil
        redirect_to "/shelters/#{@review.shelter_id}/reviews/new", notice: "All fields except for image must be filled out."
      else
        redirect_to "/shelters/#{@review.shelter_id}"
      end
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    user = User.where(name: params[:username])[0]
    review.update(review_params.merge({user: user}))
    if any_blank_fields?(review)
      redirect_to "/shelters/#{review.shelter_id}/reviews/#{review.id}/edit", notice: "All fields except for image must be filled out."
    elsif review.user_id == nil
      redirect_to "/shelters/#{review.shelter_id}/reviews/#{review.id}/edit", notice: "Please enter the name of a valid user"
    else
      redirect_to "/shelters/#{review.shelter_id}"
    end
  end

  def destroy
    Review.find(params[:review_id]).destroy
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  def any_blank_fields?(review)
    review.title == "" || review.rating == "" || review.content == ""
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image, :shelter_id)
  end
end
