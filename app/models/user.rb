class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :list, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :list_games, through: :list
  has_many :games, through: :list_games
  after_create :create_list

  def create_list
    List.create(user: self)
  end
end
