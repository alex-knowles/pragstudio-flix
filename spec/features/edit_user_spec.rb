require 'rails_helper'

describe "Editing a user" do

  it "can be navigated to from a user's detail view" do
    user = User.create!(user_attributes)
    visit user_path(user)
    click_on "Edit Account"
    expect(current_url).to eq(edit_user_url(user))
  end

end