Rails.application.routes.draw do
  root 'homes#index'
  resources :courses
  resources :users
  resources :grades
  get  '/list_courses',   to: 'courses#list'
  get 'sessions/login' => 'sessions#new'
  post 'sessions/login' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'
end
