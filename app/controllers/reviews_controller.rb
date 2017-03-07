class ReviewsController < ApplicationController

  def index
    movie_id = params[:movie_id]
    @movie = Movie.find(movie_id)
    @reviews = Review.where(movie_id:movie_id).order("created_at desc")
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new(params.require(:review).permit(:name, :stars, :comment))
    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end

end
