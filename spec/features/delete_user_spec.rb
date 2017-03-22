require 'rails_helper'

describe "Deleting a user" do

  it "deletes the user and shows the user listing without the user" do
    user = User.create!(user_attributes)
    visit user_url(user)
    click_link "Delete Account"
    expect(User.count).to eq(0)
    expect(current_url).to eq(users_url)
    expect(page).to have_text("Account deleted successfully")
  end

  it "signs the user out if signed in" do
    user = User.create!(user_attributes)
    visit signin_url
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Sign In"
    visit user_url(user)
    click_link "Delete Account"
    expect(page).to have_text("Account deleted successfully")
    expect(page).not_to have_text(user.name)
    expect(page).to have_text("Sign In")
  end

end