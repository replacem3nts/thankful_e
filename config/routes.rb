Rails.application.routes.draw do
  resources :posts
  post '/posts/query', to: 'posts#query', as: 'query'
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  get '/users/:id/posts', to: 'users#posts', as: 'user_posts'
  get '/users/:id/liked', to: 'users#liked', as: 'user_likes'
  resources :locations, only: [:index]
  resources :categories, only: [:index]
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#logout'
  get '/about', to: 'users#about'
  post '/likes', to: 'likes#create', as: 'like_post'
  delete '/likes', to: 'likes#destroy', as: 'unlike_post'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
