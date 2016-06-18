class Admin::EmployersController < EmployersController
  before_action :authenticate_admin!
end