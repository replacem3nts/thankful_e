Rails.application.routes.draw do
  resources :posts
  post '/posts/query', to: 'posts#query', as: 'query'
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :locations, only: [:index]
  resources :categories, only: [:index]
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#logout'
  get '/about', to: 'users#about'
  get '/posts/user/:id', to: 'posts#by_user', as: 'user_posts'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
