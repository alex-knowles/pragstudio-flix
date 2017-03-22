def sign_in(user)
  visit signin_url
  fill_in :email, with: user.email
  fill_in :password, with: user.password
  click_button "Sign In"
end