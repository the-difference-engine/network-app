class AddInterviewQuestionsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :interview_q1, :string
    add_column :students, :interview_q2, :string
    add_column :students, :interview_q3, :string
    add_column :students, :personal_website, :string
  end
end
