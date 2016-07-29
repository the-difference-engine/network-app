class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:sign_in, :setup_root]
  
  def sign_in
  end

  def setup_root
    path = "/sign_in"

    if admin_signed_in?
      path = "/dashboard"
    elsif employer_signed_in? || student_signed_in?
      path = "/students"
    else
      path = "/sign_in"
    end

    redirect_to path
  end
end
