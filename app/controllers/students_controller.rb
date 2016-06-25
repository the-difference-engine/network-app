class StudentsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :authenticate_admin!, :only => [:new, :create]

  def index
    @students = Student.all
    @projects = Project.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      flash[:success] = "Student account successfully created!"
      redirect_to student_path(@student)
    else
      flash[:warning] = "Unable to add new student."
      render :new
    end
  end

  def show
    @student = Student.find(params[:id])
    if @student.capstone_project
      @capstone = @student.capstone_project
    end
  end

  def edit
    @student = Student.find(params[:id])
    unless admin_signed_in? || student_signed_in? && @student.id == current_student.id
      redirect_to students_path
      flash[:warning] = "You do not have access to that page!"
    end
  end

  def update
    @student = Student.find(params[:id])

    # Allow student account update without password
    if admin_signed_in? || student_signed_in? && @student.id == current_student.id
      if student_params[:password].blank?
        student_params.delete(:password)
        student_params.delete(:password_confirmation)
      end

      successfully_updated = if needs_password?(@student, student_params)
                               @student.update(student_params)
                             else
                               @student.update_without_password(student_params)
                             end

      respond_to do |format|
        if successfully_updated
          format.html { redirect_to @student }
          flash[:success] = "Your account was successfully updated!"
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy  
    @student = Student.find(params[:id]) 

    if @student.destroy
      flash[:success] = "Student account successfully deleted!"
      redirect_to students_path
    else
      flash[:warning] = "Unable to delete the student account."
      Rails.logger.info @student.errors.messages
    end 
  end

  private

    def student_params
      params.require(:student).permit(
        :first_name, 
        :last_name,
        :avatar,
        :city,
        :industry,
        :grad_date,
        :skill_1,
        :skill_2,
        :skill_3,
        :interest_1,
        :interest_2,
        :interest_3,
        :interview_1,
        :interview_2,
        :interview_3,
        :github,
        :blog,
        :quote,
        :seeking_employment,
        :resume,
        :follow_up_list_id,
        :email,
        :password,
        :password_confirmation
      )
    end

    def needs_password?(user, params)
      params[:password].present?
    end
end
