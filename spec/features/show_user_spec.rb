require 'rails_helper'

describe "Showing a user" do 

  before do
    @edit_link_text = "Edit Account"
    @delete_link_text = "Delete Account"

    @user = User.create!(user_attributes)
    sign_in(@user)
    visit user_path @user
  end

  it "displays its attributes" do
    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.email)
  end

  it "displays its reviews" do
    movie1 = Movie.create!(movie_attributes(title: "Movie 1"))
    movie2 = Movie.create!(movie_attributes(title: "Movie 2"))
    review1 = movie1.reviews.create!(review_attributes(user: @user, stars: 1))
    review2 = movie2.reviews.create!(review_attributes(user: @user, stars: 3))
    visit user_path @user

    expect(page).to have_link(movie1.title)
    expect(page).to have_text("1 star")
    expect(page).to have_text(review1.comment)

    expect(page).to have_link(movie2.title)
    expect(page).to have_text("3 stars")
    expect(page).to have_text(review2.comment)
  end

  it "displays its favorites in the sidebar" do
    movie = Movie.create!(movie_attributes)
    @user.favorite_movies << movie
    visit user_path @user
    within("aside#sidebar") do
      expect(page).to have_text(movie.title)
    end
  end

  it "appends the user's name to the page title" do
    expect(page).to have_title("Flix - #{@user.name}")
  end

  context "that is currently signed in" do

    it "shows an 'edit' link" do
      expect(page).to have_link(@edit_link_text)
    end

    it "shows a 'delete' link" do
      expect(page).to have_link(@delete_link_text)
    end

  end

  context "that is not currently signed in" do

    before do
      @some_other_user = User.create!(user_attributes(email: "user@some.other"))
      visit user_path @some_other_user
    end

    it "does not show an 'edit' link" do
      expect(page).not_to have_link(@edit_link_text)
    end

    it "does not show a 'delete' link" do
      expect(page).not_to have_link(@delete_link_text)
    end

  end

end