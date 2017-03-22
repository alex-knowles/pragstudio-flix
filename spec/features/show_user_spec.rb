require 'rails_helper'

describe "Showing a user" do 

  it "displays its attributes" do
    @user = User.create!(user_attributes)
    sign_in(@user)
    visit user_path @user
    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.email)
  end

end