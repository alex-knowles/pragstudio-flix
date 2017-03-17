require 'rails_helper'

describe "Editing a user" do

  it "can be navigated to from a user's detail view" do
    user = User.create!(user_attributes)
    visit user_path(user)
    click_on "Edit Account"
    expect(current_url).to eq(edit_user_url(user))
  end

  it "fails when invalid data is submitted" do
    user = User.create(user_attributes)
    visit edit_user_url(user)
    invalid_name = ""
    fill_in "Name", with: invalid_name
    click_button "Update User"
    expect(page).to have_text("error")
    expect(user.name).not_to eq(invalid_name)
    expect(current_url).to eq(user_url(user))
  end

end