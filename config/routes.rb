Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'homes#index'
  resources :courses do
    member do
      get :select
      get :quit
      get :open
      get :close
    end
    collection do
      get :list
    end
  end

  resources :grades, only: [:show, :index, :update]
  resources :users

  get 'sessions/login' => 'sessions#new'
  post 'sessions/login' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
