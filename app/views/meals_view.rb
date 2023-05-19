class MealsView
  def display(meals)
    puts 'No meals yet' if meals.empty?
    meals.each do |meal|
      puts "#{meal.id}. #{meal.name} ($#{meal.price})"
    end
  end

  def ask_user_for(info)
    puts "What's the meal's #{info}?"
    print '> '
    gets.chomp
  end
end
