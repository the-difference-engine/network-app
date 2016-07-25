class AddAboutMeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :about_me, :text
  end
end
