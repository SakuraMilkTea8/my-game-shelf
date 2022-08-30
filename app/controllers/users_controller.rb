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
    # shelf in the profile partial?
    @want_to_play = []
    @now_playing = []
    @completed = []
    @user.shelf_games.each do |shelf_game|
      case shelf_game.category
      when "want to play"
        @want_to_play << shelf_game
      when "now playing"
        @now_playing << shelf_game
      when "completed"
        @completed << shelf_game
      end
    end
    # group game by category then count them to add to the graph
    @game_per_category = @user.shelf_games.group_by{|game| game.category}
    @completed_count =  @game_per_category['completed'].to_a.count
    @now_playing_count =  @game_per_category['now playing'].to_a.count
    @want_to_play_count =  @game_per_category['want to play'].to_a.count
    @graph_array = [ @completed_count, @now_playing_count, @want_to_play_count ]
    authorize @user
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

end
