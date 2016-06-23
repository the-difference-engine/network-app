class Admin::StudentsController < StudentsController
  before_action :authenticate_admin!

  def new
    @student = Student.new
  end

end
