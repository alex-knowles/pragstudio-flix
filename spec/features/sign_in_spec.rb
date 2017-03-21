require 'rails_helper'

describe "Signing in" do

  it "has a form for submitting an email and a password" do
    visit root_url
    click_on "Sign In"
    expect(current_url).to eq(signin_url)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
  end

  it "fails when an invalid email/password combination are submitted" do
    user = User.create!(user_attributes(password: "theactualpassword"))
    visit signin_url
    fill_in :email, with: user.email
    fill_in :password, with: "nottheactualpassword!?"
    click_button "Sign In"
    expect(current_path).to eq(session_path)
    expect(page).to have_text("Invalid email/password combination.")

    visit root_url
    expect(page).not_to have_link(user.name)
    expect(page).to have_link("Sign In")
    expect(page).to have_link("Sign Up")
  end

  it "succeeds when a valid email/password combination are submitted" do
    expected_name = "Gabe Kaplan"
    user = User.create!(user_attributes(name: expected_name))
    visit signin_url
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Sign In"
    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Welcome back, #{expected_name}!")

    visit root_url
    expect(page).to have_link(user.name)
    expect(page).not_to have_link("Sign In")
    expect(page).not_to have_link("Sign Up")

    click_on(user.name)
    expect(current_path).to eq(user_path(user))
  end

end