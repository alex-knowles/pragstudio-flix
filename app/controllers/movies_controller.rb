class MoviesController < ApplicationController

  def index
    @movies = ["Iron Man", "Superman", "Spiderman", "WALL-E"]
  end

end
