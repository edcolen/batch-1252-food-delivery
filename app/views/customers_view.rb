class CustomersView
  def display(customers)
    puts 'No customers yet' if customers.empty?
    customers.each do |customer|
      puts "#{customer.id}. #{customer.name} - #{customer.address}"
    end
  end

  def ask_user_for(info)
    puts "What's the customer's #{info}?"
    print '> '
    gets.chomp
  end
end
