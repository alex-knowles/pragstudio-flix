class MoviesController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.send(movies_scope)
  end

  def show
    @fans = @movie.fans
    if (signed_in)
      @current_favorite = current_user.favorites.find_by(movie: @movie)
    end
    @genres = @movie.genres
  end

  def edit
  end

  def update
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
    @movie.destroy
    redirect_to movies_path, alert: "Movie deleted successfully!"
  end

private

  def set_movie
    @movie = Movie.find_by(slug: params[:id])
  end

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
