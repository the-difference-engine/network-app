class Admin::EmployersController < EmployersController
  before_action :authenticate_admin!

  def new
    @employer = Employer.new
  end
end