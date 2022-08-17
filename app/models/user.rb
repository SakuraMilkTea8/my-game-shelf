class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :shelf_games, dependent: :destroy
  has_many :games, through: :shelf_games

  validates :name, presence: true
end
