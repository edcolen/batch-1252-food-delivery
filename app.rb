require_relative './app/repositories/meal_repository'
require_relative './app/controllers/meals_controller'

require_relative 'router'

meal_csv = File.join(__dir__, 'data', 'meals.csv')
meal_repo = MealRepository.new(meal_csv)
meals_controller = MealsController.new(meal_repo)

router = Router.new(meals_controller)

router.run
