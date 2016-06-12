class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, 
      keys: [:first_name, 
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
              :follow_up_list_id
              ])
  end
end
