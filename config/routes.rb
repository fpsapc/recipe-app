Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "recipes#index"
  get '/recipes/missing_food', to: 'recipes#missing_food', as: 'missing_food'
  get '/public_recipes' => 'recipes#public_recipes'
  resources :users do
    get :general_food_list, on: :member
  end
  resources :foods
  resources :shopping_lists, only: %i[index]
  resources :recipes
  resources :recipe_foods, only: [:new, :create, :index, :edit]
  patch '/recipe_foods/:id', to: 'recipe_foods#update', as: :update_recipe_food
  delete '/recipe_foods/:id', to: 'recipe_foods#destroy', as: :destroy_recipe_food

  # Defines the root path route ("/")
  # root "articles#index"
end
