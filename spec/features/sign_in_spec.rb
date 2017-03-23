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
    sign_in(user)
    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Welcome back, #{expected_name}!")

    visit root_url
    expect(page).to have_link(user.name)
    expect(page).not_to have_link("Sign In")
    expect(page).not_to have_link("Sign Up")

    click_on(user.name)
    expect(current_path).to eq(user_path(user))
  end

  context "after being redirected from a view requiring sign-in" do

    before do
      @user = User.create!(user_attributes)
      @restricted_url = users_url
    end

    it "redirects to the restricted view" do
      visit @restricted_url
      sign_in(@user)
      expect(current_url).to eq(@restricted_url)
    end

    it "does not redirect to the restricted view after sign out" do
      another_user = User.create!(user_attributes(email: "user@another.net"))
      visit @restricted_url
      sign_in(@user)
      click_on "Sign Out"
      sign_in(another_user)
      expect(current_url).not_to eq(@restricted_url)
      expect(current_url).to eq(user_url(another_user))
    end

  end

end