class ReviewsController < ApplicationController

  def index
    movie_id =  params[:movie_id]
    @movie = Movie.find(movie_id)
    @reviews = Review.where(movie_id:movie_id).order("created_at desc")
  end

end
