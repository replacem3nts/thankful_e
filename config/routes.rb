Rails.application.routes.draw do
  resources :postcats, only: [:index]
  resources :likes, only: [:index]
  resources :posts
  resources :users, only: [:index]
  resources :locations, only: [:index]
  resources :categories, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
