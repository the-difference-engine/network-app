class CreateJoinTableStudentTechnology < ActiveRecord::Migration
  def change
    create_join_table :students, :technologies do |t|
      # t.index [:student_id, :technology_id]
      # t.index [:technology_id, :student_id]
    end
  end
end
