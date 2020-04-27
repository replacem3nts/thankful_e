Rails.application.routes.draw do
  root 'sessions#welcome'
  get '/about', to: 'sessions#about'
  get '/map', to: 'sessions#map'
  get '/goodbye', to: 'sessions#goodbye'
  resources :posts
  resources :users, except: [:index]
  post '/posts/query', to: 'posts#query', as: 'query'
  get '/users/:id/details', to: 'users#details', as: 'details'
  patch '/users/:id/details', to: 'users#updatedetails'
  get '/users/:id/posts', to: 'users#posts', as: 'user_posts'
  get '/users/:id/liked', to: 'users#liked', as: 'user_likes'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#logout'
  post '/likes', to: 'likes#create', as: 'like_post'
  delete '/likes', to: 'likes#destroy', as: 'unlike_post'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
