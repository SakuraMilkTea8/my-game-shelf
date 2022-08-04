class Game < ApplicationRecord
  has_many :reviews
  has_many :list_games

  validates :title, presence: true
  validates :name, uniqueness: true
  validates :genre, presence: true
  validates :console, presence: true
  validates :release_date, presence: true
end
