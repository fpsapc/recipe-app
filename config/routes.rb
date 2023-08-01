Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "users#index"
  resources :users
  resources :foods
  resources :recipes
  # Defines the root path route ("/")
  # root "articles#index"
end
