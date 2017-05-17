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

  it "has many reviews" do
    user = User.new(user_attributes)
    review1 = user.reviews.new(review_attributes)
    review2 = user.reviews.new(review_attributes)
    expect(user.reviews).to include(review1)
    expect(user.reviews).to include(review2)
  end

  it "deletes associated reviews" do
    user = User.create(user_attributes)
    review = user.reviews.new(review_attributes)
    review.movie = Movie.create(movie_attributes)
    review.save
    expect {
      user.destroy
    }.to change(Review, :count).by(-1)
  end

  it "has many favorites" do
    user = User.new(user_attributes)
    movie1 = Movie.new(movie_attributes)
    movie2 = Movie.new(movie_attributes)
    favorite1 = user.favorites.new(movie: movie1)
    favorite2 = user.favorites.new(movie: movie2)
    expect(user.favorites).to include(favorite1)
    expect(user.favorites).to include(favorite2)
  end

  it "deletes associated favorites" do
    user = User.create!(user_attributes)
    movie = Movie.create!(movie_attributes)
    user.favorites.create!(movie: movie)
    expect {
      user.destroy
    }.to change(Favorite, :count).by(-1)
  end

  it "has many favorite_movies" do
    user = User.new(user_attributes)
    favorite_movie1 = Movie.new(movie_attributes)
    favorite_movie2 = Movie.new(movie_attributes)
    user.favorites.new(movie: favorite_movie1)
    user.favorites.new(movie: favorite_movie2)
    expect(user.favorite_movies).to include(favorite_movie1)
    expect(user.favorite_movies).to include(favorite_movie2)
  end

  it "can be scoped by name, ordered alphabetically" do
    user1 = User.new(user_attributes(name: 'A Smith', email: 'a.smith@mail.com'))
    user2 = User.new(user_attributes(name: 'B Smith', email: 'b.smith@mail.com'))
    user3 = User.new(user_attributes(name: 'C Smith', email: 'c.smith@mail.com'))
    user4 = User.new(user_attributes(name: 'D Smith', email: 'd.smith@mail.com'))
    user2.save!
    user1.save!
    user4.save!
    user3.save!
    expect(User.by_name).to eq([user1, user2, user3, user4])
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
