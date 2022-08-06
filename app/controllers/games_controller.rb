class GamesController < ApplicationController
  def index
      @games = Game.all
      @games = policy_scope(Game).order(created_at: :desc)
    end

  def show
    @list_game = ListGame.new
    @lists = current_user.lists
    @game = Game.find(params[:id])
    # You need this to make a new review in the show page
    @review = Review.new
    ratings = []
    @rating = 0
    @game.reviews.each do |review|
      ratings << review.rating
    end
    unless ratings.empty?
      @rating = ratings.sum / ratings.length
    end
    authorize @game
  end
end
