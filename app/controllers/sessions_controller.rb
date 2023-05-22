require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def login
    username = @view.ask_user_for('username')
    password = @view.ask_user_for('password')
    employee = @employee_repository.find_by_username(username)
    return employee if employee && employee.password == password

    @view.print_wrong_credentials
    login
  end
end
