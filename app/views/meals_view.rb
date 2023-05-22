require 'readline'
class MealsView
  def display(meals)
    puts 'No meals yet' if meals.empty?
    meals.each do |meal|
      puts "#{meal.id}. #{meal.name} ($#{meal.price})"
    end
  end

  def display_with_index(meals)
    puts 'No meals yet' if meals.empty?
    meals.each_with_index do |meal, i|
      puts "#{i + 1}. #{meal.name} ($#{meal.price})"
    end
  end

  def ask_user_for(info)
    question = info == 'id' ? "Choose a meal:" : "What's the meal's #{info}?"
    puts question
    print '> '
    gets.chomp
  end

  def edit(info, data)
    Readline.pre_input_hook = lambda {
      Readline.insert_text data.to_s
      Readline.redisplay
      Readline.pre_input_hook = nil
    }
    input = Readline.readline("#{info}: ", false)
    input.inspect.gsub('"', '')
  end
end
