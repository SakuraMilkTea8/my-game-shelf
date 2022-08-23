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
      elsif game.category == "want to play"
        @want_to_play << game
      elsif game.category == "now playing"
        @now_playing << game
        @graph_array = [@completed.count, @now_playing.count, @want_to_play.count]
      else
        print "error"
      end
    end
    authorize @user
  end
  private

  def user_params
    params.require(:user).permit(:avatar)
  end

end
