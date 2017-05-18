require 'rails_helper'

describe "Filtering movies" do

  it "shows only 'hits'" do
    movie = Movie.create!(movie_attributes(total_gross: 450000000))
    visit(root_path)
    click_link("Hits")
    expect(page).to have_text(movie.title)
  end

  it "shows only 'flops'" do
    movie = Movie.create!(movie_attributes(total_gross: 45000))
    visit(root_path)
    click_link("Flops")
    expect(page).to have_text(movie.title)
  end

  it "shows only 'upcoming'"

  it "shows only 'recent'"
  
end
