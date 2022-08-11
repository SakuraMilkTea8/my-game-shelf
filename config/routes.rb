Rails.application.routes.draw do

  devise_for :users
  resources :shelf_games, only: [:index, :create, :destroy]
  root to: 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # If we decide to have user created shelves we should add :new and :create

  resources :games, only: [:index, :show] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
end
