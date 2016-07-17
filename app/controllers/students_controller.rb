class StudentsController < ApplicationController  
  before_action :authenticate_user!
  before_action :authenticate_admin!, :only => [:new, :create, :destroy, :batch, :batch_invite]
  before_action :authenticate_admin_student!, :only => [:edit, :update]

  def index
    @students = Student.all.order(:last_name)
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
          flash[:warning] = "Unable to update your account."
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to students_path
      flash[:warning] = "You do not have access to that page!"
    end
  end

  def destroy  
    @student = Student.find(params[:id]) 
    @student.remove_avatar!
    @student.remove_resume!
    @student.save

    if @student.destroy
      flash[:success] = "Student account successfully deleted!"
      redirect_to admin_center_path
    else
      flash[:warning] = "Unable to delete the student account."
      Rails.logger.info @student.errors.messages
    end 
  end

  def batch
    render 'students/invitations/batch'
  end

  def batch_invite
    @student_array = Array.new
    params[:student_emails].split(",").each do |unparsed_email|
      if parsed_email = EmailAddress.new(unparsed_email).parse_email
        Student.create(:email => parsed_email, :invited_by_id => current_user.id, :invited_by_type => current_user.class).invite!
      @student_array << parsed_email
      end
    flash[:success] = "Invitations sent to #{@student_array.to_sentence}!"
    end
    redirect_to "/"
  end

  private

    def student_params
      params.require(:student).permit(
        :first_name, 
        :last_name,
        :avatar,
        :city,
        :current_city,
        :current_state,
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
        :linked_in,
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