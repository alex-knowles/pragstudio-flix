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

  it 'is valid with example attributes' do
    user = User.new(user_attributes)
    expect(user.valid?).to eq(true)
  end

end
