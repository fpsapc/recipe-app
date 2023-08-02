class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', optional: true

  has_many :recipe_foods
  has_many :foods, through: :recipe_foods

  def total_price
    foods.sum(:price)
  end
end
