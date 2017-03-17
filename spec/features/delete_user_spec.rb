require 'rails_helper'

describe "Deleting a user" do

  it "deletes the user and shows the user listing without the movie" do
    user = User.create!(user_attributes)
    visit user_url(user)
    click_link "Delete Account"
    expect(User.count).to eq(0)
    expect(current_url).to eq(users_url)
    expect(page).to have_text("Account deleted successfully")
  end

end