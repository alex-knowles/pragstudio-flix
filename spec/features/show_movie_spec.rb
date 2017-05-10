require 'rails_helper'

describe 'Showing a movie' do

  before do
    @movie = Movie.create!(movie_attributes)
  end

  it 'displays fans in the sidebar' do
    fan = User.create!(user_attributes)
    @movie.fans << fan
    visit movie_url(@movie)
    within("aside#sidebar") do
      expect(page).to have_text(fan.name)
    end
  end

end
