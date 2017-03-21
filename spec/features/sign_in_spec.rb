require 'rails_helper'

describe "Signing in" do

  it "has a form for submitting an email and a password" do
    visit root_url
    click_on "Sign In"
    expect(current_url).to eq(signin_url)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
  end

  it "has a button to submit email and a password" do
    visit signin_url
    expect(page).to have_button("Sign In")
  end

  it "fails when an invalid email/password combination are submitted" do
    user = User.create!(user_attributes(password: "theactualpassword"))
    visit signin_url
    fill_in :email, with: user.email
    fill_in :password, with: "nottheactualpassword!?"
    click_button "Sign In"
    expect(current_path).to eq(session_path)
    expect(page).to have_text("Invalid email/password combination.")
  end

  it "succeeds when a valid email/password combination are submitted"

end