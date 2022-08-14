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

    total = 0
    # sorted array has the best matches last so reversing it is best
    recommended_games = recommended(@game).reverse
    # still not perfect but much better than before
    @three_games = recommended_games.first(3)
    # @games.map do |element|
    #   if @game.genre == element.genre && @game.title != element.title
    #     break if total == 3

    #     @three_games << element
    #     total += 1
    #   end
    # end

  end

  private

  # def recommended(game, all_games)
  def recommended(game)
    all_games = Game.all
    game_tags = []
    game.genre.split(",").each do |genre|
      game_tags << genre
    end
    # comment out to test off heroku from here -->
    game.developer.split(",").each do |dev|
      game_tags << dev
    end
    # <-- to here
    recommended_games = []
    # check for each tag in each other game
    game_tags.each do |tag|
      all_games.each do |current_game|
        tags = []
        current_game.genre.split(",").each do |genre|
          tags << genre
        end
        # comment out to test off heroku from here -->
        current_game.developer.split(",").each do |dev|
          tags << dev
        end
        # <-- to here
        if tags.include?(tag) && current_game.title != game.title
          recommended_games << current_game
        end
      end
    end
    # tallies games by matches into a hash
    tally = recommended_games.tally
    # sorts by the times matched (higher values at the end) into an array
    sorted = recommended_games.sort_by {|key, value| value }
    return sorted
  end
end
