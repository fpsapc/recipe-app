class Food < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', optional: true

  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
