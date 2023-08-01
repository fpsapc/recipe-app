module RecipesHelper
  def format_time(time_in_minutes)
    hours = time_in_minutes / 60
    minutes = time_in_minutes % 60

    time_string = ''
    time_string << "#{hours} hour#{'s' if hours != 1}" if hours.positive?
    time_string << " #{minutes} minute#{'s' if minutes != 1}" if minutes.positive?

    time_string
  end
  def food_quantity(food)
    @user.recipes.joins(:foods).where(foods: { id: food.id }).sum('recipe_foods.quantity')
  end
end
