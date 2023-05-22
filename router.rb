class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    title
    while @running
      @current_user = @sessions_controller.login
      print `clear`
      while @current_user
        if @current_user.manager?
          display_manager_options
        else
          display_rider_options
        end
      end
    end
    puts 'Bye!'
  end

  def stop!
    logout
    @running = false
  end

  def logout
    @current_user = nil
  end

  def dispatch_manager(action)
    case action
    when 1 then meals_menu
    when 2 then customers_menu
    when 3 then orders_menu
    when 9 then logout
    when 0 then stop!
    else
      puts 'Invalid option!'
    end
  end

  def dispatch_meals(action)
    print `clear`
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @meals_controller.edit
    when 4 then @meals_controller.remove
    when 0 then display_manager_options
    else
      puts 'Invalid option!'
    end
  end

  def dispatch_customers(action)
    print `clear`
    case action
    when 1 then @customers_controller.list
    when 2 then @customers_controller.add
    when 3 then @customers_controller.edit
    when 4 then @customers_controller.remove
    when 0 then display_manager_options
    else
      puts 'Invalid option!'
    end
  end

  def dispatch_orders(action)
    print `clear`
    case action
    when 1 then @orders_controller.list
    when 2 then @orders_controller.list_undelivered_orders
    when 3 then @orders_controller.add
    when 4 then @orders_controller.edit
    when 5 then @orders_controller.remove
    when 0 then display_manager_options
    else
      puts 'Invalid option!'
    end
  end

  def dispatch_rider(action)
    case action
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 9 then logout
    when 0 then stop!
    else
      puts 'Invalid option!'
    end
  end

  def display_manager_options
    puts ''.center(40, '=')
    puts ''
    puts 'What do you want to do?'
    puts '1 - Manage meals'
    puts '2 - Manage customers'
    puts '3 - Manage orders'
    puts '9 - Logout'
    puts '0 - Exit'
    print '> '
    dispatch_manager(gets.chomp.to_i)
  end

  def meals_menu
    puts ' MEALS '.center(40, '=')
    puts ''.center(40, '=')
    puts ''
    puts '1 - List all meals'
    puts '2 - Add a meal'
    puts '3 - Edit a meal'
    puts '4 - Delete a meal'
    puts '0 - Back'
    print '> '
    dispatch_meals(gets.chomp.to_i)
  end

  def customers_menu
    puts ' CUSTOMERS '.center(40, '=')
    puts ''.center(40, '=')
    puts ''
    puts '1 - List all customers'
    puts '2 - Add a customer'
    puts '3 - Edit a customer'
    puts '4 - Delete a customer'
    puts '0 - Back'
    print '> '
    dispatch_customers(gets.chomp.to_i)
  end

  def orders_menu
    puts ' ORDERS '.center(40, '=')
    puts ''.center(40, '=')
    puts ''
    puts '1 - List all orders'
    puts '2 - List all undelivered orders'
    puts '3 - Add an order'
    puts '4 - Edit an order'
    puts '5 - Delete an order'
    puts '0 - Back'
    print '> '
    dispatch_orders(gets.chomp.to_i)
  end

  def display_rider_options
    puts ''.center(40, '=')
    puts ''
    puts 'What do you want to do?'
    puts '1 - List my undelivered orders'
    puts '2 - Mark order as delivered'
    puts '9 - Logout'
    puts '0 - Exit'
    print '> '
    dispatch_rider(gets.chomp.to_i)
  end

  def title
    print `clear`
    puts ''.center(40, '=')
    puts ' Batch #1252 Food Delivery '.center(40, '=')
    puts ''.center(40, '=')
    puts ''
  end
end
