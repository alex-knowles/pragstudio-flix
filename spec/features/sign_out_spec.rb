require 'rails_helper'

describe "Signing out" do

  before do
    @user = User.create!(user_attributes)
    visit signin_url
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Sign In"
  end

  it "ends the current session" do
    visit root_url
    click_on("Sign Out")
    expect(current_url).to eq(root_url)
    expect(page).not_to have_text(@user.name)
    expect(page).to have_text("Sign In")
  end

end
