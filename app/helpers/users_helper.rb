module UsersHelper
  def total_quantity_for_food(food)
    @user.recipes.joins(:foods).where(foods: { id: food.id }).sum('recipe_foods.quantity')
  end
end
