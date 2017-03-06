require 'rails_helper'

describe "Creating a review" do

  it "saves the review" do
    movie = Movie.create(movie_attributes)
    visit movie_url(movie)
    click_link "Write Review"
    expect(current_path).to eq(new_movie_review_path(movie))

    fill_in "Name", with: "Roger Ebert"
    select 3, :from => "review_stars"
    fill_in "Comment", with: "I laughed, I cried, I spilled my popcorn!"
    click_button "Post Review"
    expect(current_path).to eq(movie_reviews_path(movie))
    expect(page).to have_text("Thanks for your review!")
  end

end