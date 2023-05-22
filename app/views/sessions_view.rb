require 'io/console'
class SessionsView
  def ask_user_for(info)
    question = info == 'id' ? "Choose an employee:" : "Type your #{info}"
    puts question
    print '> '
    info == 'password' ? $stdin.noecho(&:gets).chomp : gets.chomp
  end

  def print_wrong_credentials
    print `clear`
    puts 'Wrong credentials. Try again...'
  end

  def display_with_index(employees)
    puts 'No employees yet' if employees.empty?
    employees.each_with_index do |employee, i|
      puts "#{i + 1}. #{employee.username}"
    end
  end
end
