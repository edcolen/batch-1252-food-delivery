require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'
require_relative '../views/sessions_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @sessions_view = SessionsView.new
    @orders_view = OrdersView.new
  end

  def list
    orders = @order_repository.all
    @orders_view.display(orders)
  end

  def add
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
    list
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @orders_view.display(undelivered_orders)
  end

  def list_my_orders(current_user)
    orders = @order_repository.my_undelivered_orders(current_user)
    @orders_view.display_with_index(orders)
  end

  def mark_as_delivered(current_user)
    list_my_orders(current_user)
    index = @meals_view.ask_user_for('id').to_i - 1
    my_orders = @order_repository.my_undelivered_orders(current_user)
    order = my_orders[index]
    @order_repository.mark_as_delivered(order)
  end

  def edit
    list
    id = @orders_view.ask_user_for('id').to_i
    order = @order_repository.find(id)
    order.meal = select_meal
    order.customer = select_customer
    order.employee = select_employee
    @order_repository.update
    list
  end

  def remove
    list
    id = @view.ask_user_for('id').to_i
    @order_repository.destroy(id)
    list
  end

  def select_meal
    meals = @meal_repository.all
    @meals_view.display_with_index(meals)
    index = @meals_view.ask_user_for('id').to_i - 1
    meals[index]
  end

  def select_customer
    customers = @customer_repository.all
    @customers_view.display_with_index(customers)
    index = @customers_view.ask_user_for('id').to_i - 1
    customers[index]
  end

  def select_employee
    employees = @employee_repository.all_riders
    @sessions_view.display_with_index(employees)
    index = @sessions_view.ask_user_for('id').to_i - 1
    employees[index]
  end
end
