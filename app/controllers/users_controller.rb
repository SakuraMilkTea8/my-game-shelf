class UsersController < ApplicationController
  include Pundit
  before_action :verify_authorized, except: [:show]

  def show
    @games = Game.all
    # users can click on other users reviews with this
    @user = User.find(params[:id])

    # users can follow other users
    @users = User.all
    # @users.each do |user|
    #   user
    # end
    # raise
    authorize @user
  end
end
