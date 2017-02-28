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
    click_button "Create Movie"
    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text(expected_title)
  end

end
