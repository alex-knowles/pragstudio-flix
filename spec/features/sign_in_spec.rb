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

end