class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :require_signin, only: [:index, :new, :create]

  def index
    @reviews = Review.where(movie_id: @movie.id).order("created_at desc")
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(params.require(:review).permit(:stars, :comment))
    @review.user = current_user
    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end

private

  def set_movie
    @movie = Movie.find_by(slug: params[:movie_id])
  end

end
