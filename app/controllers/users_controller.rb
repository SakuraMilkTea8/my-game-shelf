class UsersController < ApplicationController
  include Pundit
  before_action :verify_authorized, except: [:show]

  def show
    @games = Game.all
    # users can find other users with this
    @user = User.find(params[:id])
    authorize @user
  end
end
