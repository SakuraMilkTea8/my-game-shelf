class Game < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :shelf_games, dependent: :destroy

  validates :title, presence: true
  validates :genre, presence: true
  validates :console, presence: true
  validates :release_date, presence: true


  include PgSearch::Model
  pg_search_scope :search_by_title_and_genre,
    against: [ :title, :genre ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
