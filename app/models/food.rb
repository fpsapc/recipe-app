class Food < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'

  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods
end
