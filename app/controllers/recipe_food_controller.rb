class RecipeFoodController < ApplicationController
  # def index
  #   @recipe_foods = RecipeFood.all
  # end

  def new
    @recipe_food = RecipeFood.new
    @foods = []
    @ids = RecipeFood.where(recipe_id: params[:recipe_id]).pluck(:food_id)
    Food.where(user: current_user).each do |f|
      @foods << [f.name, f.id] unless @ids.include?(f.id)
    end
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params.merge(recipe_id: @recipe.id))
    if @recipe_food.save
      flash[:notice] = 'Food created sucessfully.'
      redirect_to @recipe
    else
      render :new
    end
  end

  private
  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
