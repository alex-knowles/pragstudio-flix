require 'rails_helper'

describe "Editing a user" do

  it "can be navigated to from a user's detail view" do
    user = User.create!(user_attributes)
    visit user_path(user)
    click_on "Edit Account"
    expect(current_url).to eq(edit_user_url(user))
  end

  it "succeeds when valid data is submitted" do
    user = User.create(user_attributes)
    visit edit_user_url(user)
    valid_name = "Walter Sobchak"
    fill_in "Name", with: valid_name
    click_button "Update Account"
    expect(current_url).to eq(user_url(user))
    user = User.find(user.id)
    expect(user.name).to eq(valid_name)
    expect(page).to have_text("Account successfully updated!")
  end

  it "fails when invalid data is submitted" do
    user = User.create(user_attributes)
    visit edit_user_url(user)
    invalid_name = ""
    fill_in "Name", with: invalid_name
    click_button "Update Account"
    expect(page).to have_text("error")
    expect(user.name).not_to eq(invalid_name)
    expect(current_url).to eq(user_url(user))
  end

end