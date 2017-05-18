class MoviesController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @movies = Movie.send(movies_scope)
  end

  def show
    @movie = Movie.find(params[:id])
    @fans = @movie.fans
    if (signed_in)
      @current_favorite = current_user.favorites.find_by(movie: @movie)
    end
    @genres = @movie.genres
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie updated successfully!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie created successfully!"
    else
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, alert: "Movie deleted successfully!"
  end

private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on,
     :total_gross, :cast, :director, :duration, :image_file_name, genre_ids: [])
  end

  def movies_scope
    expected_scopes = %w(hits flops upcoming recent)
    if params[:scope].in? expected_scopes
      params[:scope]
    else
      :released
    end
  end

end
