class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    if admin_signed_in?
      current_admin
    elsif student_signed_in?
      current_student
    elsif employer_signed_in?
      current_employer
    end
  end

  def authenticate_user!
    if current_admin
      :authenticate_admin!
    elsif current_student
      :authenticate_student!
    elsif current_employer
      :authenticate_employer!
    else 
      redirect_to "/sign_in"
    end
  end

  def authenticate_admin_employer!
    if current_admin
      :authenticate_admin!
    elsif current_employer
      :authenticate_employer!
    else 
      redirect_to "/students"
      flash[:warning] = "You do not have access!"
    end
  end

  def authenticate_admin_student!
    if current_admin
      :authenticate_admin!
    elsif current_student
      :authenticate_student!
    else 
      redirect_to "/students"
      flash[:warning] = "You do not have access!"
    end
  end

protected

  # def configure_permitted_parameters
  #   # Only add some parameters
  #   devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name, :description, :name, :rep_first_name, :rep_last_name, :rep_phone, :rep_email, :city, :state, :description, :invited_by_id, :invited_by_type]
  #   # Override accepted parameters
  #   # devise_parameter_sanitizer.for(:accept_invitation) do |u|
  #   #   u.permit(:first_name, :last_name, :phone, :password, :password_confirmation,
  #   #            :invitation_token)
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [
      :first_name, 
      :last_name,
      :avatar,
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
      :follow_up_list_id,
      :name,
      :image,
      :description,
      :rep_first_name,
      :rep_last_name,
      :rep_phone,
      :rep_email,
      :website,
      :state,
      :email,
      :currently_hiring,
      :hiring_timeline,
      :number_of_positions,
      :company_size,
      :about_me,
      :active,
      :remove_avatar,
      :remove_resume,
      :remove_image,
      :remove_project_image,
      :employer_id,
      :password,
      :password_confirmation,
      :invited_by_id, 
      :invited_by_type,
      position_ids: [],
      position_type_ids: [],
      industry_ids: [],
      salary_range_ids: [],
      technology_ids: [],
      student_ids: []
    ]
  end

  def authenticate_inviter!
    authenticate_admin!(:force => true)
  end
end
