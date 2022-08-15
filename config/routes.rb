Rails.application.routes.draw do
  # changed for user profiles to appear
  devise_for :users, :path_prefix => 'd'
  resources :users, :only => [:show]

  resources :shelf_games, only: [:index, :create, :update, :destroy]
  root to: 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # If we decide to have user created shelves we should add :new and :create

  resources :games, only: [:index, :show] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
end
