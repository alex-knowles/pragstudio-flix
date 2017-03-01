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
    movie1 = Movie.create(movie_attributes(released_on: 3.months.ago))
    movie2 = Movie.create(movie_attributes(released_on: 2.months.ago))
    movie3 = Movie.create(movie_attributes(released_on: 1.months.ago))

    expect(Movie.released).to eq([movie3, movie2, movie1])
  end

  it "requires a title" do
    movie = Movie.new(title: "")
    movie.valid?
    expect(movie.errors[:title].any?).to eq(true)
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

end
