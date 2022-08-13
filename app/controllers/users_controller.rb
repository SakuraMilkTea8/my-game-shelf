class UsersController < ApplicationController
  include Pundit
  before_action :verify_authorized, except: [:show]

  def show
    @user = User.find(params[:id])
    authorize @show
  end
end
