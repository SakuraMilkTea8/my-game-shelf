class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    # You need this to make a new review in the show page
    @review = Review.new
  end
end
