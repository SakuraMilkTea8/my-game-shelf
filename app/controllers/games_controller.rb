class GamesController < ApplicationController
  def index
    @games = Game.all
    @games = policy_scope(Game).order(created_at: :desc)
  end

  # def recommended
  #   show
  #   # @game.genre = game_genre
  #   # @game.title = game_title
  #   index
  #   total = 0
  #   @games.each do |game|
  #     if game.genre == game_genre && game.title != game_title
  #       break if total == 3

  #       total += 1
  #       link_to game_path(game)
  #     end
  #   end
  # end

  def show
    # for the recommended games to appear in the show page
    # recommended
    index
    @game = Game.find(params[:id])
    authorize @game
    # if the user is not signed in they cannot add a game to a list
    if user_signed_in?
      # list_game is either present with an id or not yet made
      @shelf_game = current_user.list_games.find_by(game: @game) || ShelfGame.new
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
  end
end
