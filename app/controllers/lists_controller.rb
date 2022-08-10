class ListsController < ApplicationController
  def index
    list = current_user.list
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

  def show
  end

  def edit
  end

  def update
  end
end
