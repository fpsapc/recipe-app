class RecipeFoodsController < ApplicationController
  def index; end

  def new
    @recipe_food = RecipeFood.new
    @foods = []
    @recipe = Recipe.find(params[:recipe_id])
    @ids = RecipeFood.where(recipe_id: params[:recipe_id]).pluck(:food_id)
    Food.where(user: current_user).each do |f|
      @foods << [f.name, f.id] unless @ids.include?(f.id)
    end
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_path(@recipe_food.recipe), notice: 'Recipe Food was successfully created.'
    else
      render :new
    end
  end

  def edit
    @recipe_food = RecipeFood.includes(:food).find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe_food.recipe), notice: 'Recipe Food was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe_food.recipe), notice: 'Recipe Food was successfully deleted.'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end
end
