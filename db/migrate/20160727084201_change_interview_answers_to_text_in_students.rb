class ChangeInterviewAnswersToTextInStudents < ActiveRecord::Migration
  def change
    change_column :students, :interview_1, :text
    change_column :students, :interview_2, :text
    change_column :students, :interview_3, :text
  end
end
