require "rails_helper"

describe "Viewing a movie" do

  it "shows the movie's details" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text(movie.released_on)
  end

  it "shows the total gross if the total gross exceeds $50M" do
    movie = Movie.create(movie_attributes(total_gross: 60000000.00))
    visit movie_url(movie)
    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create(movie_attributes(total_gross: 49999999.99))
    visit movie_url(movie)
    expect(page).to have_text("Flop!")
  end

  it "shows average star rating if there is at least 1 review" do
    movie = Movie.create!(movie_attributes)
    user = User.create!(user_attributes)
    expected_stars = 2.0
    movie.reviews.create!(review_attributes(stars: expected_stars, user: user))
    visit movie_url(movie)
    expect(page).to have_text("#{expected_stars} stars")
  end

  it "shows 'No reviews' if there are 0 reviews" do
    movie = Movie.create(movie_attributes)
    visit movie_url(movie)
    expect(page).to have_text("No reviews")
  end

end