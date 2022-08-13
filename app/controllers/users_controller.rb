class UsersController < ApplicationController
  include Pundit
  after_action :verify_authorized, except: [:show]

  def show
    @user = User.find(params[:id])
  end
end
