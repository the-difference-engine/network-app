class Admin::EmployersController < EmployersController
  before_action :authenticate_user!
  before_action :authenticate_admin!, :only => [:new, :create]
  # skip_before_action :require_no_authentication

end