require 'rails_helper'

describe 'A user' do

  it 'requires a name' do
    user = User.new(name: "")
    user.valid?
    expect(user.errors[:name].any?).to eq(true)
  end

  it 'requires an email' do
    user = User.new(email: "")
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end

  it 'accepts an email that is formatted correctly' do
    user = User.new(email: "user@example.com")
    user.valid?
    expect(user.errors[:email].any?).to eq(false)
  end

  it 'rejects an email that is formatted incorrectly' do
    user = User.new(email: "user_at_example_dot_com")
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end

  it 'requires a password' do
    user = User.new(password: "")
    user.valid?
    expect(user.errors[:password].any?).to eq(true)
  end

  it 'rejects a password less than 10 characters long' do
    user = User.new(password: "123456789")
    user.valid?
    expect(user.errors[:password].any?).to eq(true)
  end

  it 'can be updated without re-submitting the password' do
    user = User.create!(user_attributes)
    user2 = User.find_by(email: user.email)
    expect(user2.password).to be_nil
    user2.update(name: "")
  end

  it 'is valid with example attributes' do
    user = User.new(user_attributes)
    expect(user.valid?).to eq(true)
  end

  it 'requires a unique, case-insensitive email address' do
    user1 = User.create!(user_attributes(email: "user@mail.com"))
    user2 = User.new(user_attributes(email: "USER@mail.COM"))
    user2.valid?
    expect(user2.errors[:email].any?).to eq(true)
  end

end

describe 'authenticate' do
  before do
    @user = User.create!(user_attributes)
  end

  it "returns non-true if the email does not match" do
    result = User.authenticate("not-the-email", @user.password)
    expect(result).not_to be_truthy
  end

  it "returns non-true if the password does not match" do
    result = User.authenticate(@user.email, "not-the-password")
    expect(result).not_to be_truthy
  end

  it "returns true if the email and password do match" do
    result = User.authenticate(@user.email, @user.password)
    expect(result).to be_truthy
  end
end
