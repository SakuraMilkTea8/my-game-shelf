class UsersController < ApplicationController
  include Pundit
  before_action :verify_authorized, except: [:show, :toggle_favorite]
  # before_action :authenticate_user!, only: :toggle_favorite

  def toggle_favorite
    @user = User.find_by(id: params[:id])
    current_user.favorited?(@user)  ? current_user.unfavorite(@user) : current_user.favorite(@user)
    respond_to do |format|
      format.html
      format.js
    end
    authorize @user
  end

  def show
    @games = Game.all
    # users can click on other users reviews with this
    @user = User.find(params[:id])
    # users can follow other users
    @users = User.all
    @favorite_users = current_user.favorited_by_type('User')

    respond_to do |format|
      format.html
      format.js
    end
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
end
