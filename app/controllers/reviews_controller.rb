class ReviewsController < ApplicationController

  before_action :set_movie

  def index
    @reviews = Review.where(movie_id: @movie.id).order("created_at desc")
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(params.require(:review).permit(:name, :stars, :comment))
    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end

private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

end
