class CreateFollowUpStudents < ActiveRecord::Migration
  def change
    create_table :follow_up_students do |t|
      t.integer :student_id
      t.integer :follow_up_list_id
      t.integer :employer_id

      t.timestamps null: false
    end

    drop_table :follow_up_lists_students
  end
end
