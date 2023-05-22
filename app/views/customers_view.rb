class CustomersView
  def display(customers)
    puts 'No customers yet' if customers.empty?
    customers.each do |customer|
      puts "#{customer.id}. #{customer.name} - #{customer.address}"
    end
  end

  def display_with_index(customers)
    puts 'No customers yet' if customers.empty?
    customers.each_with_index do |customer, i|
      puts "#{i + 1}. #{customer.name} - #{customer.address}"
    end
  end

  def ask_user_for(info)
    question = info == 'id' ? "Choose a customer:" : "What's the customer's #{info}?"
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
