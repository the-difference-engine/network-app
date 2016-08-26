class StudentEmailsController < ApplicationController
  def create
    @student_email = StudentEmail.new(params[:student_email])
    @student_email.request = request

    if @student_email.deliver
      @student_email_record = StudentEmailRecord.new()
      @student_email_record.student_id = @student_email.student_id.to_i
      @student_email_record.employer_id = @student_email.employer_id.to_i
      @student_email_record.save
      
      flash[:success] = "Email sent to #{@student_email_record.employer.name}!"
      redirect_to "/"
    else
      flash[:warning] = "Message cannot be sent"
      render "students/show"
    end
  end
end
