class FollowUpStudentsController < ApplicationController
  before_action :authenticate_admin_employer!

  def new
    @follow_up_student = FollowUpStudent.new
  end

  def create
    @follow_up_student = FollowUpStudent.new(
      follow_up_student_params
    )

    if @follow_up_student.save
      flash[:success] = "Student added to your follow up list"
      redirect_to :back
      Rails.logger.info @follow_up_student.attributes
    else 
      render "students/show"
    end
  end

  def destroy
  end

  private

    def follow_up_student_params
      params.require(:follow_up_student).permit(:student_id, :follow_up_list_id, :employer_id)
    end
end
