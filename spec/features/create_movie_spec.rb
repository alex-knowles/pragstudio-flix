require 'rails_helper'

describe "Creating a new movie" do

  context "while signed in" do

    before do
      user = User.create!(user_attributes(admin: true))
      sign_in(user)
    end

    it "saves the movie and shows the new movie's details" do
      visit movies_url
      click_link "Add New Movie"
      expect(current_path).to eq(new_movie_path)

      expected_title = "New Movie Title"
      fill_in "Title", with: expected_title
      fill_in "Description", with: "Superheroes saving the world from villains"
      select "PG-13", :from => "Rating"
      fill_in "Total gross", with: "75000000"
      select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"
      fill_in "Cast", with: "The award-winning cast"
      fill_in "Director", with: "The ever-creative director"
      fill_in "Duration", with: "123 min"
      fill_in "Image file name", with: "movie.png"
      click_button "Create Movie"
      expect(current_path).to eq(movie_path(Movie.last))
      expect(page).to have_text(expected_title)
      expect(page).to have_text("Movie created successfully!")
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

    it "does not save the movie if it's invalid" do
      visit new_movie_url
      expect {
          click_button 'Create Movie'
      }.not_to change(Movie, :count)
      expect(current_path).to eq(movies_path)
      expect(page).to have_text('error')
    end

  end

end
