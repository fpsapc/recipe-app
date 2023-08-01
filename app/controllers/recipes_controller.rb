class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def public_recipes
    @recipes = Recipe.where(public: true)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      flash[:notice] = 'Recipe was successfully created.'
      redirect_to recipes_path
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = if current_user.id == @recipe.user.id
      RecipeFood.where(recipe_id: @recipe.id).includes(:recipe, :food)
    else
      RecipeFood.where(recipe_id: @recipe.id).includes(:food)
    end
  end

  def edit; end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'Recipe was successfully deleted.'
    redirect_to recipes_path
  end
  
  def missing_food
    @user = current_user
    @general_food_list = @user.foods.group(:name).select('foods.name, SUM(foods.quantity) as total_quantity, SUM(foods.price * foods.quantity) as total_price')
    
    @food_used_in_recipes = @user.foods.joins(:recipe_foods).group(:name).select('foods.name, SUM(recipe_foods.quantity) as total_quantity')
  
    @missing_food = @general_food_list.map do |general_food|
      used_food = @food_used_in_recipes.find { |food| food.name == general_food.name }
      difference_quantity = used_food ? used_food.total_quantity - general_food.total_quantity : general_food.total_quantity
  
      # If difference_quantity is less than zero, set it to zero and total_price to zero as well
      if difference_quantity < 0
        difference_quantity = 0
        general_food.total_price = 0
      else
        general_food.total_price = general_food.total_price * difference_quantity
      end
  
      OpenStruct.new(name: general_food.name, total_quantity: difference_quantity, total_price: general_food.total_price)
    end
  end
  
  
 def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  private
  def authorize_user
    unless @recipe.user == current_user
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
