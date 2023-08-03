class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    return unless user

    # Abilities for all users
    can %i[read create], Food
    can %i[read create], Recipe
    can %i[read create], RecipeFood

    # Abilities for the user's own records
    can %i[update destroy], Food, user_id: user.id
    can %i[update destroy], Recipe, user_id: user.id
    can %i[update destroy], RecipeFood, user_id: user.id
  end
end
