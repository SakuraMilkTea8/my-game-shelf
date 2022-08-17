class UsersController < ApplicationController
  include Pundit
  before_action :verify_authorized, except: [:show]

  def show
    @games = Game.all
    @user = current_user
    # @game = Game.find(params[:id])
    authorize @user
  end
end
