require 'rails_helper'

describe "A genre" do

  it "requires a name" do
    genre = Genre.new(name: "")
    genre.valid?
    expect(genre.errors[:name].any?).to eq(true)
  end

  it "rejects a non-unique name" do
    genre1 = Genre.create!(name: "foo")
    genre2 = Genre.new(name: "foo")
    genre2.valid?
    expect(genre2.errors[:name].any?).to eq(true)
  end

end
