class ReviewsController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    @review = Review.new(review_params)
    @review.game = @game
    if @review.save
      redirect_to game_path(@game)
    else
      render 'games/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
