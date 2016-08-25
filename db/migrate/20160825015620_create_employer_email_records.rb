class CreateEmployerEmailRecords < ActiveRecord::Migration
  def change
    create_table :employer_email_records do |t|
      t.integer :employer_id
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
