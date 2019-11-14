Rails.application.routes.draw do
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

  resources :grades, only: [:index, :update]
  resources :users

  get 'sessions/login' => 'sessions#new'
  post 'sessions/login' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'
  resources :account_activations, only: [:edit]
end
