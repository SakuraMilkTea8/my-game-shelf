class ShelfGamesController < ApplicationController
  def index
    # creates the link path to get the users show page
    @user = current_user
    @users = User.all
    shelf_games = policy_scope(ShelfGame).includes(:game).order(created_at: :desc)
    @favorite_users = current_user.favorited_by_type('User')
    @want_to_play = []
    @now_playing = []
    @completed = []
    shelf_games.each do |shelf_game|
      if shelf_game.category == 'want to play'
        @want_to_play << shelf_game
      elsif shelf_game.category == 'now playing'
        @now_playing << shelf_game
      elsif shelf_game.category == 'completed'
        @completed << shelf_game
      end
    end
    @user.reviews.each do |review|
      @game = Game.find(review.game.id)
    end
    # this shows the graph
    @game_per_category = @user.shelf_games.group_by{|game| game.category}
    @completed_number =  @game_per_category['completed'].to_a.count
    @now_playing_number =  @game_per_category['now playing'].to_a.count
    @want_to_play_number =  @game_per_category['want to play'].to_a.count
    @graph_array = [ @completed_number, @now_playing_number, @want_to_play_number ]
    # respond_to do |format|
    #   format.html
    #   format.js
    # end

    @user.shelf_games.each do |game|
      @category = game.category
      @latest_game = Game.find([game.game_id])
      @latest_game.each do |content|
        @title = content.title
        @image = content.image_url
        @updated_at = (content.updated_at)
      end
    end
  end

  def create
    @game = Game.find(params[:game_id])
    @shelf_game = ShelfGame.new(shelf_game_params)
    authorize @shelf_game
    @shelf_game.game = @game
    @shelf_game.user = current_user
    @shelf_game.save
    redirect_to game_path(@game)
  end

  def update
    @shelf_game = ShelfGame.find(params[:id])
    authorize @shelf_game
    @shelf_game.update(shelf_game_params)
    @shelf_game.save
  end

  def destroy
    shelf_game = ShelfGame.find(params[:id])
    authorize shelf_game
    shelf_game.delete

    redirect_to shelf_games_path
  end

  private

  def shelf_game_params
    params.require(:shelf_game).permit(:category)
  end
end
