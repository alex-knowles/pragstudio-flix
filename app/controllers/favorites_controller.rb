class FavoritesController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @favorite = @movie.favorites.create!(user: current_user)
    redirect_to(@movie, notice: "Thanks for fav'ing!")
  end

end
