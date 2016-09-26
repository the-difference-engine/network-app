class StudentsController < ApplicationController  
  before_action :authenticate_user!
  before_action :authenticate_admin!, :only => [:new, :create, :destroy, :batch, :batch_invite]
  before_action :authenticate_admin_student!, :only => [:edit, :update]

  def index
    @search = Student.search(params[:q])
    @students = @search.result(distinct: true)
    @students = @students.where.not(
      resume: [nil, ""], 
      about_me: [nil, ""], 
      avatar: [nil, ""], 
      skill_1: [nil, ""], 
      skill_2: [nil, ""], 
      skill_3: [nil, ""], 
      active: false
    )

    @students = @students.joins(:technologies, :positions).sort_by_standout_score.reverse
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
      render :new
    end
  end

  def show
    @student = Student.find(params[:id])
    
    if @student.active || current_admin || current_student && current_student.id == @student.id
      @projects = @student.projects
      @technologies = @student.technologies if @student.technologies.any?
      @positions = @student.positions if @student.positions.any?
      @industries = @student.industries if @student.industries.any?
      @employer = current_employer if current_employer
      @follow_up_list = @employer.follow_up_list if current_employer
      @follow_up_student = FollowUpStudent.new
      @employer_email = EmployerEmail.new

      @default_message = "Greetings #{@student.full_name}!\n\n#{@employer.rep_full_name} from #{@employer.name } viewed your profile on DevHero and would like to connect!\n\nView their employer profile http://network-app-staging.com/employers/#{@employer.id} or reply to this email to start a conversation." if current_employer
      # @default_message = "Greetings #{@student.full_name}!\n\n#{@employer.rep_full_name} from #{@employer.name } viewed your profile on DevHero and would like to connect!\n\nView their employer profile http://devhero.io/employers/#{@employer.id} or reply to this email to start a conversation." if current_employer

      if @student.capstone_project
        @capstone = @student.capstone_project
      end
    else
      redirect_to students_path
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
          sign_in(@student, :bypass => true)
          format.html { redirect_to @student }
          flash[:success] = "Your account was successfully updated!"
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
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

  private

    def student_params
      params.require(:student).permit(
        :first_name, 
        :last_name,
        :avatar,
        :remove_avatar,
        :city,
        :current_city,
        :current_state,
        :current_industry,
        :grad_date,
        :skill_1,
        :skill_2,
        :skill_3,
        :interest_1,
        :interest_2,
        :interest_3,
        :interview_q1,
        :interview_q2,
        :interview_q3,
        :interview_1,
        :interview_2,
        :interview_3,
        :github,
        :blog,
        :personal_website,
        :linked_in,
        :quote,
        :seeking_employment,
        :resume,
        :remove_resume,
        :about_me,
        :active,
        :follow_up_list_id,
        :email,
        :password,
        :password_confirmation,
        follow_up_list_ids: [],
        technology_ids: [],
        industry_ids: [],
        position_ids: []
      )
    end

    def needs_password?(user, params)
      params[:password].present?
    end
end