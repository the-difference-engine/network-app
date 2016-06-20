class AdminsController < ApplicationController
  before_action :authenticate_admin!
  
  
  def index
  end

  def show
  end

  def admin_center
    @employers = Employer.all
    @students = Student.all
  end
end
