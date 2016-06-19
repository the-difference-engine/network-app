class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_current_user
    @current_user = current_admin || current_student || current_employer
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
      flash[:warning] = "You do not have access! Please sign in or sign up"
    end
  end

  def authenticate_admin_employer!
    if current_admin
      :authenticate_admin!
    elsif current_employer
      :authenticate_employer!
    else 
      redirect_to "/sign_in"
      flash[:warning] = "You do not have access! Please sign in or sign up"
    end
  end

  def authenticate_admin_student!
    if current_admin
      :authenticate_admin!
    elsif current_student
      :authenticate_student!
    else 
      redirect_to "/sign_in"
      flash[:warning] = "You do not have access! Please sign in or sign up"
    end
  end

end
