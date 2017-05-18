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

  it "shows only 'upcoming'" do
    movie = Movie.create!(movie_attributes(released_on: Date.tomorrow))
    visit(root_path)
    click_link("Upcoming")
    expect(page).to have_text(movie.title)
  end

  it "shows only 'recent'" do
    recent_movie = Movie.create!(movie_attributes(released_on: Date.yesterday))
    not_recent_movie = Movie.create!(movie_attributes(title: "World War Hulk", released_on: Date.tomorrow))
    visit(root_path)
    click_link("Recent")
    expect(page).to have_text(recent_movie.title)
    expect(page).not_to have_text(not_recent_movie.title)
  end
  
end
