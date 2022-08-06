class ReviewsController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    @review = Review.new(review_params)
    @review.game = @game
    @review.user = current_user
    if @review.save
      redirect_to game_path(@game)
    else
      render 'games/show'
    end
    authorize @review
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
