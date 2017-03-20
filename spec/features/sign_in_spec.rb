require 'rails_helper'

describe "Signing in" do

  it "has a form for submitting an email and a password" do
    visit root_url
    click_on "Sign In"
    expect(current_url).to eq(new_session_url)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
  end

end