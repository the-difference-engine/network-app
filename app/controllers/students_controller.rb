class StudentsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @students = Student.all
    @projects = Project.all
  end

  def show
    @student = Student.find(params[:id])
    @capstone = @student.capstone_project
  end
end
