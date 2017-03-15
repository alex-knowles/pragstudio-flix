require 'rails_helper'

describe "Viewing the list of users" do

  before do
    @user1 = User.create!(user_attributes(name: "Alice Smith"))
    @user2 = User.create!(user_attributes(name: "Bob Smith", email: "bob@smith.com"))
    @user3 = User.create!(user_attributes(name: "Charles Smith", email: "charles@smith.com"))
  end

  it "shows the users" do
    visit users_url
    expect(page).to have_text(@user1.name)
    expect(page).to have_text(@user2.name)
    expect(page).to have_text(@user3.name)
  end

  it "shows the total number of users" do
    visit users_url
    expect(page).to have_text("3 Users")
  end

end
