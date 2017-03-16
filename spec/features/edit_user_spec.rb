require 'rails_helper'

describe "Editing a user" do

  it "can be navigated tp from a user's detail view" do
    user = User.create!(user_attributes)
    visit user_path(user)
    click_on "Edit Account"
  end

end