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

end
