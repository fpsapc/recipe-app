class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', optional: true

  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, length: { maximum: 250 }
  validates :name, :preparation_time, :cooking_time, :description, presence: true
  validates :preparation_time, :cooking_time, comparison: { greater_than_or_equal_to: 0 }

  def total_price
    foods.sum(:price)
  end
end
