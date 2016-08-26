class EmployerEmailsController < ApplicationController
  before_action :authenticate_admin_employer!

  def create
    @employer_email = EmployerEmail.new(params[:employer_email])
    @employer_email.request = request

    if @employer_email.deliver
      @employer_email_record = EmployerEmailRecord.new()
      @employer_email_record.student_id = @employer_email.student_id.to_i
      @employer_email_record.employer_id = @employer_email.employer_id.to_i
      @employer_email_record.save
      
      flash[:success] = "Email sent to #{@employer_email_record.student.full_name}!"
      redirect_to "/"
    else
      flash[:warning] = "Message cannot be sent"
      render "students/show"
    end
  end
end
