class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def set_current_user
    @current_user = current_admin || current_student || current_employer
  end

  def authenticate_user!
    if @current_user == current_admin
      :authenticate_admin!
    elsif @current_user == current_student
      :authenticate_student!
    elsif @current_user == current_employer
      :authenticate_employer!
    end
  end

end
