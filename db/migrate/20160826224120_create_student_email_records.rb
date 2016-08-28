class CreateStudentEmailRecords < ActiveRecord::Migration
  def change
    create_table :student_email_records do |t|
      t.integer :student_id
      t.integer :employer_id

      t.timestamps null: false
    end
  end
end
