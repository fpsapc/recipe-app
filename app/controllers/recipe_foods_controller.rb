class RecipeFoodsController < ApplicationController
  def index; end

  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_foods_path, notice: 'Recipe Food was successfully created.'
    else
      render :new
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end
end
