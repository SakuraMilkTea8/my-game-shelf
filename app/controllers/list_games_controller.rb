class ListGamesController < ApplicationController
  def index
    list_games = current_user.list_games
    @want_to_play = []
    @now_playing = []
    @completed = []
    list_games.each do |list_game|
      if list_game.category = 'want to play'
        @want_to_play << list_game.game
      elsif list_game.category = 'now playing'
        @now_playing << list_game.game
      elsif list_game.category = 'completed'
        @completed << list_game.game
      end
    end
  end

  def create
    @game = Game.find(params[:game].to_i)
    @list_game = ListGame.new(list_game_params)
    authorize @list_game
    @list_game.game = @game
    @list_game.list = current_user.list
    if @list_game.save
      redirect_to game_path(@game)
    else
      render 'games/show'
    end
  end

  def update

  end

  def destroy
  end

  private

  def list_game_params
    params.require(:list_game).permit(:category)
  end
end
