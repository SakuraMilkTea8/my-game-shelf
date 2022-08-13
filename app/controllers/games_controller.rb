class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @games = policy_scope(Game).search_by_title_and_genre(params[:query])
    else
      @games = Game.all
      @games = policy_scope(Game).order(created_at: :desc)
    end
  end

  def show
    @games = Game.all
    @game = Game.find(params[:id])
    authorize @game
    # if the user is not signed in they cannot add a game to a list
    if user_signed_in?
      # list_game is either present with an id or not yet made
      @shelf_game = current_user.shelf_games.find_by(game: @game) || ShelfGame.new
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

    # recommended games (should be in a private method)
    total = 0
    # can be done in sql
    @three_games = []
    @games.map do |element|
      if @game.genre == element.genre && @game.title != element.title
        break if total == 3

        @three_games << element
        total += 1
      end
    end

  end

  private

  # def recommended(game, all_games)
end
