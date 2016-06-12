class AddFieldsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :follow_up_list_id, :integer
    add_column :students, :avatar, :string
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    add_column :students, :city, :string
    add_column :students, :industry, :string
    add_column :students, :grad_date, :date
    add_column :students, :skill_1, :string
    add_column :students, :skill_2, :string
    add_column :students, :skill_3, :string
    add_column :students, :interest_1, :string
    add_column :students, :interest_2, :string
    add_column :students, :interest_3, :string
    add_column :students, :interview_1, :string
    add_column :students, :interview_2, :string
    add_column :students, :interview_3, :string
    add_column :students, :github, :string
    add_column :students, :blog, :string
    add_column :students, :quote, :string
    add_column :students, :seeking_employment, :boolean, default: false
    add_column :students, :resume, :string
  end
end
