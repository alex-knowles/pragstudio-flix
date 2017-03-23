require 'rails_helper'

describe "Showing a user" do 

  before do
    @edit_link_text = "Edit Account"
    @delete_link_text = "Delete Account"

    @user = User.create!(user_attributes)
    sign_in(@user)
    visit user_path @user
  end

  it "displays its attributes" do
    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.email)
  end

  context "that is currently signed in" do

    it "shows an 'edit' link" do
      expect(page).to have_link(@edit_link_text)
    end

    it "shows a 'delete' link" do
      expect(page).to have_link(@delete_link_text)
    end

  end

  context "that is not currently signed in" do

    before do
      @some_other_user = User.create!(user_attributes(email: "user@some.other"))
      visit user_path @some_other_user
    end

    it "does not show an 'edit' link" do
      expect(page).not_to have_link(@edit_link_text)
    end

    it "does not show a 'delete' link" do
      expect(page).not_to have_link(@delete_link_text)
    end

  end

end