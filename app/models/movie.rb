class Movie < ApplicationRecord

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: {greater_than_or_equal_to: 0}

  def flop?
    total_gross.blank? || total_gross < 50000000
  end

  def self.released
    where("released_on <= ?", Date.today).order("released_on desc")
  end

end
