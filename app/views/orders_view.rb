class OrdersView
  def display(orders)
    puts 'No orders yet' if orders.empty?
    orders.each do |order|
      delivered = order.delivered? ? '[X]' : '[ ]'
      name = order.meal.name
      customer = order.customer.name
      employee = order.employee.username
      puts "#{order.id}. #{delivered} Meal: #{name} | Customer: #{customer} | Employee: #{employee}"
    end
  end

  def display_with_index(orders)
    puts 'No orders yet' if orders.empty?
    orders.each_with_index do |order, i|
      delivered = order.delivered? ? '[X]' : '[ ]'
      name = order.meal.name
      customer = order.customer.name
      employee = order.employee.username
      puts "#{i + 1}. #{delivered} Meal: #{name} | Customer: #{customer} | Employee: #{employee}"
    end
  end

  def ask_user_for(info)
    question = info == 'id' ? "Choose an order:" : "What's the order's #{info}?"
    puts question
    print '> '
    gets.chomp
  end
end
