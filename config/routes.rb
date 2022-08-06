Rails.application.routes.draw do

  devise_for :users
  resources :list_games, only: [:create, :destroy]
  root to: 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # If we decide to have user created shelves we should add :new and :create
  resources :lists, only: [:edit, :update, :index, :show]

  resources :games, only: [:index, :show] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
end
