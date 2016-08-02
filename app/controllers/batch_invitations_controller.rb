class BatchInvitationsController < ApplicationController
  def create
    @invite_send_success = Array.new
    @invite_send_errors = Array.new
    @invite_send_duplicate = Array.new
    if params[:type] == 'student'
      user_type = Student
    params[:student_emails].split(",").each do |unparsed_email|
      if parsed_email = EmailAddress.new(unparsed_email).parse_email
        if Student.find_by(email: parsed_email.to_s)
          @invite_send_duplicate << unparsed_email
        else
        Student.create(:email => parsed_email, :invited_by_id => current_user.id, :invited_by_type => current_user.class).invite!
        @invite_send_success << parsed_email
        end
      else
        @invite_send_errors << unparsed_email
      end
      
      if @invite_send_success.length > 0
        flash[:success] = "Invitation(s) successfully sent to #{@invite_send_success.to_sentence}"
      end

      if @invite_send_errors.length > 0
        flash[:warning] = "Invitation(s) not sent to #{@invite_send_errors.to_sentence}"
      end

      if @invite_send_duplicate.length > 0
        flash[:warning] = "Invitation(s) not sent to #{@invite_send_duplicate.to_sentence}"
      end
    end
    redirect_to "/"
  end
end
