class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :content, length: { minimum: 6 }
  validates :content, presence: true
  validates :rating, presence: true
end
