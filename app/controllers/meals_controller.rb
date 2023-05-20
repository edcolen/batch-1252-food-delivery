require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def list
    meals = @meal_repository.all
    @view.display(meals)
  end

  def add
    name = @view.ask_user_for('name')
    price = @view.ask_user_for('price').to_i
    meal = Meal.new(name: name, price: price)
    @meal_repository.create(meal)
    list
  end

  def edit
    list
    id = @view.ask_user_for('id').to_i
    meal = @meal_repository.find(id)
    meal.name = @view.edit('name', meal.name)
    meal.price = @view.edit('price', meal.price).to_i
    @meal_repository.update
    list
  end

  def remove
    list
    id = @view.ask_user_for('id').to_i
    @meal_repository.destroy(id)
    list
  end
end
