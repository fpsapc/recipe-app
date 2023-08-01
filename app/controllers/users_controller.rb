class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def general_food_list
    @user = current_user
    @general_food_list = @user.foods.group(:name).select('foods.name, SUM(foods.quantity) as total_quantity, SUM(foods.price * foods.quantity) as total_price')
  end
end
