require_relative './base_repository'
require_relative '../models/employee'

class EmployeeRepository < BaseRepository
  undef_method :create

  def build_element(row)
    row[:id] = row[:id].to_i
    Employee.new(row)
  end

  def all_riders
    @elements.select { |element| element.rider? }
  end

  def find_by_username(username)
    @elements.find { |element| element.username == username }
  end
end
