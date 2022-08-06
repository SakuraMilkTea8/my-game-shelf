Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/edit'
  get 'reviews/update'
  get 'reviews/destroy'
  get 'games/index'
  get 'games/show'
  get 'list_games/create'
  get 'list_games/destroy'
  get 'lists/index'
  get 'lists/show'
  get 'lists/edit'
  get 'lists/update'
  devise_for :users
  root to: 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # If we decide to have user created shelves we should add :new and :create
  resources :lists, only: [:edit, :update, :index, :show] do
    resources :list_games, only: [:create, :destroy]
  end

  resources :games, only: [:index, :show] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
end
