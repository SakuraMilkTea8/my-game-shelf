class ShelfGame < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :category, presence: true
end
