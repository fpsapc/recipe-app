class ShoppingListsController < ApplicationController
  def index
    @recipes = current_user.recipes.includes(:recipe_foods).includes(:foods)
    @sum = 0
  end
end
