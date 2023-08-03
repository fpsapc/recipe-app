class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @recipes = if current_user
                 Recipe.where(user_id: current_user.id).includes(:user)
               else
                 []
               end
  end

  def public_recipes
    @recipes = Recipe.includes(:user, recipe_foods: %i[food]).where(public: true).order(created_at: :desc)
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

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def authorize_user
    return if @recipe.user == current_user

    redirect_to root_path, alert: 'You are not authorized to perform this action.'
  end
end
