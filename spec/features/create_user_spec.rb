require 'rails_helper'

describe "Creating a user" do

  it "can be navigated to from the root" do
    visit root_url
    click_link 'Sign Up'
    expect(current_path).to eq(signup_path)
  end

  it "succeeds when valid data is submitted" do
    visit signup_path
    fill_in "Name", with: "Anderson Dawes"
    fill_in "Email", with: "adawes@ceres.net"
    fill_in "Password", with: "beltersunite"
    fill_in "Password confirmation", with: "beltersunite"
    click_button 'Create Account'
    expect(User.count).to eq(1)
    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_text("Thanks for signing up!")
  end

  it "fails when invalid data is submitted" do
    visit signup_url
    expect {
      click_button 'Create Account'
    }.not_to change(User, :count)
    expect(page).to have_text('error')
    expect(current_path).to eq(users_path)
  end

end