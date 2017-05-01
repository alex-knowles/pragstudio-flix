require 'rails_helper'

describe 'Fave-ing a movie' do

  before do
    user = User.create!(user_attributes)
    sign_in(user)
  end

  it "increases the movie's fan count by 1" do
    movie = Movie.create!(movie_attributes)
    visit movie_url(movie)
    expect {
      click_button("Fave")
    }.to change(movie.fans, :count).by(1)
  end

  it "replaces the 'Fave' button with 'Unfave'" do
    movie = Movie.create!(movie_attributes)
    visit movie_url(movie)
    expect(page).not_to have_button("Unfave")
    click_button("Fave")
    expect(page).to have_button("Unfave")
  end

end
