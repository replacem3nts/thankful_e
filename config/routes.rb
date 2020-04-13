Rails.application.routes.draw do
  resources :postcats
  resources :likes
  resources :posts
  resources :users
  resources :locations
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
