class FavoritesController < ApplicationController
  before_action :require_signin

  def create
    @movie = Movie.find(params[:movie_id])
    @favorite = @movie.favorites.create!(user: current_user)
    redirect_to(@movie, notice: "Thanks for fav'ing!")
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @movie = Movie.find(params[:movie_id])
    @favorite.destroy!
    redirect_to(@movie, notice: "Sorry!")
  end

end
