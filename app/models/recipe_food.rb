class RecipeFood < ApplicationRecord
    belongs_to :food
    belongs_to :recipe

    validates :food_id, presence: true
    validates :recipe_id, presence: true
    validates :quantity, presence: true
end
