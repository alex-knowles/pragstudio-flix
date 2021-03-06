require 'rails_helper'

describe "A movie" do

  it "is a flop if the total gross is less than $50M" do
    movie = Movie.new(total_gross: 49999999.99)
    expect(movie.flop?).to eq(true)
  end

  it "is not a flop if the total gross is more than $50M" do
    movie = Movie.new(total_gross: 51000000.00)
    expect(movie.flop?).to eq(false)
  end

  it "is released when the released on date is in the past" do
    movie = Movie.create(movie_attributes(released_on: Date.yesterday))

    expect(Movie.released).to include(movie)
  end

  it "is not released when the released on date is in the future" do
    movie = Movie.create(movie_attributes(released_on: Date.tomorrow))

    expect(Movie.released).not_to include(movie)
  end

  it "returns released movies ordered with the most recently-released movie first" do
    movie1 = Movie.create(movie_attributes(released_on: 3.months.ago, title: "movie1"))
    movie2 = Movie.create(movie_attributes(released_on: 2.months.ago, title: "movie2"))
    movie3 = Movie.create(movie_attributes(released_on: 1.months.ago, title: "movie3"))

    expect(Movie.released).to eq([movie3, movie2, movie1])
  end

  it "is 'upcoming' when the released on date is in the future" do
    movie = Movie.create!(movie_attributes(released_on: Date.tomorrow))
    expect(Movie.upcoming).to include(movie)
  end

  it "returns 'upcoming' movies ordered with the soonest-to-be-released first" do
    soonest = Movie.new(movie_attributes(released_on: Date.tomorrow, title: "title1"))
    next_latest = Movie.new(movie_attributes(released_on: 2.months.from_now, title: "title2"))
    latest = Movie.new(movie_attributes(released_on: 3.months.from_now, title: "title3"))
    next_latest.save!
    latest.save!
    soonest.save!
    expect(Movie.upcoming).to eq([soonest, next_latest, latest])
  end

  context "given a varied range of grossing movies" do
    before do
      # flops gross less than $50 million
      fifty_million = 50000000
      @flop1 = Movie.new(movie_attributes(total_gross: fifty_million - 3, title: "flop1"))
      @flop2 = Movie.new(movie_attributes(total_gross: fifty_million - 2, title: "flop2"))
      @flop3 = Movie.new(movie_attributes(total_gross: fifty_million - 1, title: "flop3"))
      @flop2.save
      @flop1.save
      @flop3.save

      # hits gross more $300 million or more
      three_hundred_million = 300000000
      @hit1 = Movie.new(movie_attributes(total_gross: three_hundred_million + 0, title: "hit1"))
      @hit2 = Movie.new(movie_attributes(total_gross: three_hundred_million + 1, title: "hit2"))
      @hit3 = Movie.new(movie_attributes(total_gross: three_hundred_million + 2, title: "hit3"))
      @hit2.save
      @hit1.save
      @hit3.save

      # some movies are neither hits nor flops
      @middling1 = Movie.create!(movie_attributes(total_gross: fifty_million + 0, title: "middling1"))
      @middling2 = Movie.create!(movie_attributes(total_gross: fifty_million + 1, title: "middling2"))
      @middling3 = Movie.create!(movie_attributes(total_gross: fifty_million + 2, title: "middling3"))
    end

    it "returns 'flop' movies ordered with the lowest-grossing first" do
      expect(Movie.flops).to eq([@flop1, @flop2, @flop3])
    end

    it "returns 'hit' movies ordered with the highest-grossing first" do
      expect(Movie.hits).to eq([@hit3, @hit2, @hit1])
    end

    it "excludes unreleased movies from flops and hits" do
      movie1 = Movie.create!(movie_attributes(released_on: Date.tomorrow, title: "movie1", total_gross: 0))
      movie2 = Movie.create!(movie_attributes(released_on: Date.tomorrow, title: "movie2", total_gross: 500000000))
      expect(Movie.flops).not_to include(movie1)
      expect(Movie.hits).not_to include(movie2)
    end

  end

  it "can be scoped by a specified rating" do
    rated_g = Movie.create!(movie_attributes(rating: 'G', title: "rated_g"))
    rated_pg = Movie.create!(movie_attributes(rating: 'PG', title: "rated_pg"))
    rated_pg_13 = Movie.create!(movie_attributes(rating: 'PG-13', title: "rated_pg_13"))
    expect(Movie.rated('PG')).to eq([rated_pg])
  end

  it "does not include unreleased movies when scoped by 'rating'" do
    rating = 'PG'
    released = Movie.create!(movie_attributes(rating: rating, released_on: Date.yesterday, title: "released"))
    unreleased = Movie.create!(movie_attributes(rating: rating, released_on: Date.tomorrow, title: "unreleased"))
    expect(Movie.rated(rating)).to include(released)
    expect(Movie.rated(rating)).not_to include(unreleased)
  end

  context "given some movies with a varied range of release dates" do
    before do
      @movie1 = Movie.create!(movie_attributes(released_on: 1.days.ago, title: "title1"))
      @movie2 = Movie.create!(movie_attributes(released_on: 2.days.ago, title: "title2"))
      @movie3 = Movie.create!(movie_attributes(released_on: 3.days.ago, title: "title3"))
      @movie4 = Movie.create!(movie_attributes(released_on: 4.days.ago, title: "title4"))
      @movie5 = Movie.create!(movie_attributes(released_on: 5.days.ago, title: "title5"))
      @movie6 = Movie.create!(movie_attributes(released_on: 6.days.ago, title: "title6"))
    end

    it "can be scoped to 'recent' titles with a default max number of 5" do
      expect(Movie.recent.count).to eq(5)
      expect(Movie.recent).not_to include(@movie6)
    end

    it "can be scoped to 'recent' titles with a specified max number" do
      expect(Movie.recent(3).count).to eq(3)
    end

  end

  it "requires a title" do
    movie = Movie.new(title: "")
    movie.valid?
    expect(movie.errors[:title].any?).to eq(true)
  end

  it "rejects a title that is not unique" do
    title = "Citizen Kane"
    movie1 = Movie.create!(movie_attributes(title: title))
    movie2 = Movie.new(title: title)
    movie2.valid?
    expect(movie2.errors[:title].any?).to eq(true)
  end

  it "generates a slug" do
    movie = Movie.create!(movie_attributes)
    expect(movie.slug).not_to be_nil
    expect(movie.slug.length).to be > 0
  end

  it "rejects a slug that is not unique" do
    movie1 = Movie.create!(movie_attributes)
    movie2 = Movie.new(movie_attributes)
    movie2.valid?
    expect(movie2.errors[:slug].any?).to eq(true)
  end

  it "requires a description" do
    movie = Movie.new(description: "")
    movie.valid?
    expect(movie.errors[:description].any?).to eq(true)
  end

  it "requires a released on date" do
    movie = Movie.new(released_on: "")
    movie.valid?
    expect(movie.errors[:released_on].any?).to eq(true)
  end

  it "requires a duration" do
    movie = Movie.new(duration: "")
    movie.valid?
    expect(movie.errors[:duration].any?).to eq(true)
  end

  it "requires a description over 24 characters" do
    movie = Movie.new(description: "X" * 24)
    movie.valid?
    expect(movie.errors[:description].any?).to eq(true)
  end

  it "accepts a $0 total gross" do
    movie = Movie.new(total_gross: 0.00)
    movie.valid?
    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it "accepts a positive total gross" do
    movie = Movie.new(total_gross: 10000000.00)
    movie.valid?
    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it "rejects a negative total gross" do
    movie = Movie.new(total_gross: -10000000.00)
    movie.valid?
    expect(movie.errors[:total_gross].any?).to eq(true)
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png movie.png movie.jpg movie.gif MOVIE.GIF]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(false)
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[movie .jpg .png .gif movie.pdf movie.doc]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(true)
    end
  end

  it "accepts blank image file name" do
    movie = Movie.new(image_file_name: "")
    movie.valid?
    expect(movie.errors[:image_file_name].any?).to eq(false)
  end

  it "accepts any rating that is in the approved list" do
    ratings = %w[G PG PG-13 R NC-17]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)
      movie.valid?
      expect(movie.errors[:rating].any?).to eq(false)
    end
  end

  it "rejects any rating that is not in the approved list" do
    ratings = %w[R-13 R-16 R-18 R-21]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)
      movie.valid?
      expect(movie.errors[:rating].any?).to eq(true)
    end
  end

  it "is valid with example attributes" do
    movie = Movie.new(movie_attributes)
    expect(movie.valid?).to eq(true)
  end

  it "has many reviews" do
    movie = Movie.new(movie_attributes)
    review1 = movie.reviews.new(review_attributes)
    review2 = movie.reviews.new(review_attributes)
    expect(movie.reviews).to include(review1)
    expect(movie.reviews).to include(review2)
  end

  it "deletes associated reviews" do
    movie = Movie.create(movie_attributes)
    user = User.create(user_attributes)
    movie.reviews.create!(review_attributes(user: user))
    expect {
      movie.destroy
    }.to change(Review, :count).by(-1)
  end

  it "calculates an average star rating of its reviews" do
    movie = Movie.create(movie_attributes)
    user = User.create(user_attributes)
    movie.reviews.create!(review_attributes(stars: 1, user: user))
    movie.reviews.create!(review_attributes(stars: 5, user: user))
    movie.reviews.create!(review_attributes(stars: 3, user: user))
    expect(movie.average_stars).to eq(3)
  end

  it "has many favorites" do
    movie = Movie.new(movie_attributes)
    user1 = User.new(user_attributes)
    user2 = User.new(user_attributes)
    favorite1 = movie.favorites.new(user: user1)
    favorite2 = movie.favorites.new(user: user2)
    expect(movie.favorites).to include(favorite1)
    expect(movie.favorites).to include(favorite2)
  end

  it "deletes associated favorites" do
    movie = Movie.create!(movie_attributes)
    user = User.create!(user_attributes)
    movie.favorites.create!(user: user)
    expect {
      movie.destroy
    }.to change(Favorite, :count).by(-1)
  end

  it "has many fans" do
    movie = Movie.new(movie_attributes)
    fan1 = User.new(user_attributes)
    fan2 = User.new(user_attributes)
    movie.favorites.new(user: fan1)
    movie.favorites.new(user: fan2)
    expect(movie.fans).to include(fan1)
    expect(movie.fans).to include(fan2)
  end

  it "has many genres" do
    movie = Movie.new(movie_attributes)
    genre1 = Genre.new(name: "Comedy")
    genre2 = Genre.new(name: "Horror")
    movie.genres << genre1
    movie.genres << genre2
    expect(movie.genres).to include(genre1)
    expect(movie.genres).to include(genre2)
  end

end
