class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :list_games, through: :lists
  has_many :games, through: :list_games
  after_create :create_lists

  def create_lists
    List.create(name: 'want to play', user: self)
    List.create(name: 'now playing', user: self)
    List.create(name: 'completed', user: self)
  end
end
