class EmployerEmailsController < ApplicationController
  def create
    @employer_email = EmployerEmail.new(params[:employer_email])
    @employer_email.request = request

    if @employer_email.deliver
      flash[:success] = "Email sent!"
      redirect_to "/"
    else
      flash[:warning] = "Message cannot be sent"
      render "students/show"
    end
  end
end
