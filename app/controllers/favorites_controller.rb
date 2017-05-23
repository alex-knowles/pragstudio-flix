class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    @favorite = @movie.favorites.create!(user: current_user)
    redirect_to(@movie, notice: "Thanks for fav'ing!")
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy!
    redirect_to(@movie, notice: "Sorry!")
  end

private

  def set_movie
    @movie = Movie.find_by(slug: params[:movie_id])
  end

end
