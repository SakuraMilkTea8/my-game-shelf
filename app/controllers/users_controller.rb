class UsersController < ApplicationController
  include Pundit
  before_action :verify_authorized, except: [:show]

  def show
    @games = Game.all
    # users can click on other users reviews with this
    @user = User.find(params[:id])
    # users can follow other users
    @users = User.all
    # for the shelf list on users profile
    @want_to_play = []
    @now_playing = []
    @completed = []
    @user.shelf_games.each do |game|
      if game.category == "completed"
          @completed << game.category
          @completed_count = @completed.count
          @completed_json = @completed_count.to_json
      elsif game.category == "want to play"
          @want_to_play << game
          @want_to_play_count = @want_to_play.count
      else game.category == "now playing"
          @now_playing << game
          @now_playing_count = @now_playing.count
      end
    end
      # raise
    authorize @user
  end
end
