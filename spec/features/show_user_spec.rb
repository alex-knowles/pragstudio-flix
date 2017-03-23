require 'rails_helper'

describe "Showing a user" do 

  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it "displays its attributes" do
    visit user_path @user
    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.email)
  end

  context "that is currently signed in" do

    it "shows an 'edit' link" do
      visit user_path @user
      expect(page).to have_link("Edit Account")
    end

    it "shows a 'delete' link" do
      visit user_path @user
      expect(page).to have_link("Delete Account")
    end

  end

end