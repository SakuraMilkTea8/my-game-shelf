class List < ApplicationRecord
  belongs_to :user
  has_many :list_games
end
