require 'rails_helper'

describe 'Unfave-ing a move' do

  before do
    @movie = Movie.create!(movie_attributes)
    user = User.create!(user_attributes)
    favorite = @movie.favorites.create!(user: user)    
    sign_in(user)
  end

  it "decreases the movie's fan count by 1" do
    visit movie_url(@movie)
    expect {
      click_button("Unfave")
    }.to change(Favorite, :count).by(-1)
  end

  it "replaces the 'Unfave' button with 'Fave'" do
    visit movie_url(@movie)
    click_button("Unfave")
    expect(page).not_to have_button("Unfave")
    expect(page).to have_button("Fave")
  end

end
