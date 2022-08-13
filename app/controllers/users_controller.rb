class UsersController < ApplicationController
  include Pundit
  before_action :verify_authorized, except: [:show]

  def show
    @games = Game.all
    @game = Game.find(params[:id])
    @user = User.find(params[:id])
    authorize @user
  end
end
