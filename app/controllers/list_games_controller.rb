class ListGamesController < ApplicationController
  def create
    @game = Game.find(params[:game].to_i)
    @list_game = ListGame.new(list_game_params)
    @list_game.game = @game
    if @list_game.save
      redirect_to game_path(@game)
    else
      render 'games/show'
    end
    authorize @list_game
  end

  def destroy
  end

  private

  def list_game_params
    params.require(:list_game).permit(:list_id)
  end
end
