class ShelfGamesController < ApplicationController
  def index
    # creates the link path to get the users show page
    @user = current_user
    shelf_games = policy_scope(ShelfGame).includes(:game).order(created_at: :desc)
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
