Rails.application.routes.draw do
  resources :postcats, only: [:index]
  resources :likes, only: [:index]
  resources :posts
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :locations, only: [:index]
  resources :categories, only: [:index]
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
