class ListGamesController < ApplicationController
  def create
    @list_game = ListGame.new(list_game_params)
    @list_game.user = current_user
    @list_game.save
  end

  def destroy
  end

  private

  def list_game_params
    params.require(:list_game).permit(:game, :list)
  end
end
