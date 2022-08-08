class GamesController < ApplicationController
  def index
    @games = Game.all
    @games = policy_scope(Game).order(created_at: :desc)
  end

  def show
    # for the recommended games to appear in the show page
    index
    @game = Game.find(params[:id])
    # if the user is not signed in they cannot add a game to a list
    if user_signed_in?
      # list_game is either present with an id or not yet made
      @list_game = current_user.list_games.find_by(game: @game) || ListGame.new
      @lists = current_user.lists
      # You need this to make a new review in the show page
    end
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
