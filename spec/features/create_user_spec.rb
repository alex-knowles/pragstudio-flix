require 'rails_helper'

describe "Creating a user" do

  it "succeeds when valid data is submitted"

  it "shows the user's details after saving"

  it "fails when invalid data is submitted" do
    visit signup_url
    expect {
      click_button 'Sign Up'
    }.not_to change(User, :count)
    expect(page).to have_text('error')
    expect(current_path).to eq(users_path)
  end

end