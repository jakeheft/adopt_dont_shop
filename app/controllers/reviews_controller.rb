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
    if @review.user == nil
      redirect_to "/shelters/#{@review.shelter_id}/reviews/new", notice: "Please enter the name of a valid user"
    elsif @review.id == nil
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
    if review.title == "" || review.rating == "" || review.content == "" || review.user == ""
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
end
