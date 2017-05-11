require 'rails_helper'

describe 'Showing a movie' do

  before do
    @movie = Movie.create!(movie_attributes)
  end

  it "shows the movie's details" do
    visit movie_url(@movie)

    expect(page).to have_text(@movie.title)
    expect(page).to have_text(@movie.rating)
    expect(page).to have_text(@movie.description)
    expect(page).to have_text(@movie.released_on)
  end

  it "shows the total gross if the total gross exceeds $50M" do
    @movie = Movie.create(movie_attributes(total_gross: 60000000.00))
    visit movie_url(@movie)
    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    @movie = Movie.create(movie_attributes(total_gross: 49999999.99))
    visit movie_url(@movie)
    expect(page).to have_text("Flop!")
  end

  it "shows average star rating if there is at least 1 review" do
    user = User.create!(user_attributes)
    expected_stars = 2.0
    @movie.reviews.create!(review_attributes(stars: expected_stars, user: user))
    visit movie_url(@movie)
    expect(page).to have_text("#{expected_stars} stars")
  end

  it "shows 'No reviews' if there are 0 reviews" do
    visit movie_url(@movie)
    expect(page).to have_text("No reviews")
  end

  it 'displays fans in the sidebar' do
    fan = User.create!(user_attributes)
    @movie.fans << fan
    visit movie_url(@movie)
    within("aside#sidebar") do
      expect(page).to have_text(fan.name)
    end
  end

  it 'displays genres in the sidebar' do
    genre = Genre.create!(name: 'A Genre')
    @movie.genres << genre
    visit movie_url(@movie)
    within("aside#sidebar") do
      expect(page).to have_text(genre.name)
    end
  end

  it "appends the movie's title and release year to the page title" do
    @movie = Movie.create!(movie_attributes(title: "The Matrix", released_on: "1999-03-21"))
    visit movie_url(@movie)
    expect(page).to have_title("Flix - The Matrix (1999)")
  end

end
