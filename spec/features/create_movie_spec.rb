require 'rails_helper'

describe "Creating a new movie" do

  it "saves the movie and shows the new movie's details" do
    visit movies_url
    click_link "Add New Movie"
    expect(current_path).to eq(new_movie_path)

    expected_title = "New Movie Title"
    fill_in "Title", with: expected_title
    fill_in "Description", with: "Superheroes saving the world from villains"
    fill_in "Rating", with: "PG-13"
    fill_in "Total gross", with: "75000000"
    fill_in "Released on", with:(Time.new.year - 1).to_s
    fill_in "Cast", with: "The award-winning cast"
    fill_in "Director", with: "The ever-creative director"
    fill_in "Duration", with: "123 min"
    fill_in "Image file name", with: "movie.png"
    click_button "Create Movie"
    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text(expected_title)
  end

  it "has 'Cancel' link that returns to the index page without changing anything" do
    expect(Movie.count).to eq(0)
    visit movies_url
    click_link "Add New Movie"

    canceled_title = "New Movie Title"
    fill_in 'Title', with: canceled_title
    click_link 'Cancel'
    expect(current_path).to eq(movies_path)
    expect(Movie.count).to eq(0)
    expect(page).not_to have_text(canceled_title)
  end

end
