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

  context "given a valid new password" do
    before do
      @user = User.create!(user_attributes(password: 'anOlderCodeButItChecksOut'))
      @old_password_digest = @user.password_digest
      visit edit_user_url(@user)
      @new_password = 'thisIsMyNewPassword'
      fill_in "Password", with: @new_password
      fill_in "Password confirmation", with: @new_password
    end

    it "does not blank the password field when an invalid name is submitted" do
      expect(find_field("Password").value).to eq(@new_password)
      expect(find_field("Password confirmation").value).to eq(@new_password)

      fill_in "Name", with: ""
      click_button "Update Account"
      expect(page).to have_text("error")
      expect(current_url).to eq(user_url(@user))
      expect(find_field("Password").value).to eq(@new_password)
      expect(find_field("Password confirmation").value).to eq(@new_password)
      @user = User.find(@user.id)
      expect(@user.password_digest).to eq(@old_password_digest)
    end
  end

end