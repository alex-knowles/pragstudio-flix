require 'rails_helper'

describe "Viewing the list of users" do

  it "shows the users" do
    user1 = User.create(user_attributes(name: "Alice Smith"))
    visit users_url
    expect(page).to have_text(user1.name)
  end

end
