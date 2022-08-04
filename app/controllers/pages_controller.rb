class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  # would we be able to use this method to get lists made on sign up?
  def create_lists
    List.create(name: 'completed', user_id: current_user.id)
    List.create(name: 'currently playing', user_id: current_user.id)
    List.create(name: 'want to play', user_id: current_user.id)
  end
end
