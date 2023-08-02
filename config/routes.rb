Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "users#index"
  get '/recipes/missing_food', to: 'recipes#missing_food', as: 'missing_food'
  get '/public_recipes' => 'recipes#public_recipes'
  resources :users do
    get :general_food_list, on: :member
  end
  resources :foods
  resources :recipes
  resources :recipe_foods, only: [:new, :create, :index]

  # Defines the root path route ("/")
  # root "articles#index"
end
