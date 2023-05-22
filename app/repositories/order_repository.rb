require_relative './base_repository'
require_relative '../models/order'

class OrderRepository < BaseRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @elements = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def build_element(row)
    row[:id] = row[:id].to_i
    row[:meal] = @meal_repository.find(row[:meal_id].to_i)
    row[:customer] = @customer_repository.find(row[:customer_id].to_i)
    row[:employee] = @employee_repository.find(row[:employee_id].to_i)
    row[:delivered] = row[:delivered] == 'true'
    Order.new(row)
  end

  def undelivered_orders
    @elements.reject { |element| element.delivered? }
  end

  def mark_as_delivered(element)
    element.deliver!
    save_csv
  end

  def my_undelivered_orders(employee)
    @elements.select { |element| element.employee == employee && !element.delivered? }
  end
end
