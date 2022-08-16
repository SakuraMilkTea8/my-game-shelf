class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # creates the link path to get the users show page
    @user = current_user
    # for the search bar
    if params[:query].present?
      @games = policy_scope(Game).search_by_title_and_genre(params[:query])
    else
      @games = Game.all
      @games = policy_scope(Game).order(created_at: :desc)
    end
  end

  def show
    # creates the link path to get the users show page
    @user = current_user
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
    @rating = ratings.sum / ratings.length unless ratings.empty?


    # still not perfect but much better than before
    recommended_games = recommended(@game)
    @three_games = recommended_games.keys.first(3)
    # @games.map do |element|
    #   if @game.genre == element.genre && @game.title != element.title
    #     break if total == 3

    #     @three_games << element
    #     total += 1
    #   end
    # end

  end

  private

  def get_tags(game)
    game_tags = []
    game.genre.split(",").each do |genre|
      game_tags << genre
    end
    # comment out to test off heroku from here -->
    game.developer.split(",").each do |dev|
      game_tags << dev
    end
    # <-- to here
    return game_tags
  end

  def tally_recommendations(games_array)
    # tallies the games into a hash and organizes it by highest tally first
    return games_array.tally.sort_by { |_key, value| -value }.to_h
  end

  def recommended(game)
    all_games = Game.all
    game_tags = get_tags(game)
    recommended_games = []
    # check for each tag in each other game
    game_tags.each do |tag|
      all_games.each do |current_game|
        tags = get_tags(current_game)
        recommended_games << current_game if tags.include?(tag) && current_game.title != game.title
      end
    end
    return tally_recommendations(recommended_games)
  end
end
