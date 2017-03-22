require 'rails_helper'

describe "Signing out" do

  it "ends the current session" do
    user = User.create!(user_attributes)
    sign_in(user)
    visit root_url
    click_on("Sign Out")
    expect(current_url).to eq(root_url)
    expect(page).not_to have_text(user.name)
    expect(page).to have_text("Sign In")
    expect(page).to have_text("You're now signed out!")
  end

end
