class Review < ApplicationRecord
  belongs_to :movie

  validates :name, presence: true
  validates :comment, length: { minimum: 4 }

end
