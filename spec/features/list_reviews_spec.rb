require 'rails_helper'

describe "Viewing a list of reviews" do

  before do
    user = User.create!(user_attributes)
    sign_in(user)
  end

  it "shows the reviews for a specific movie" do
    user = User.create!(user_attributes(name: "Roger Ebert", email: "roger@ebert.net"))
    movie1 = Movie.create(movie_attributes(title: "Iron Man"))
    comment1 = "This movie was really excellent!"
    review1 = movie1.reviews.create!(review_attributes(comment: comment1, user: user))
    comment2 = "This movie was really excellent! I just had to review it a second time."
    review2 = movie1.reviews.create!(review_attributes(comment: comment2, user: user))

    movie2 = Movie.create(movie_attributes(title: "Superman"))
    comment3 = "I was not so into this one.  Would not recommend."
    review3 = movie2.reviews.create!(review_attributes(comment: comment3, user: user))

    visit movie_reviews_url(movie1)

    expect(page).to have_text(comment1)
    expect(page).to have_text(comment2)
    expect(page).not_to have_text(comment3)
  end

end