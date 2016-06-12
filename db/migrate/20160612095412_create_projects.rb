class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :student_id
      t.string :name
      t.text :description
      t.boolean :capstone
      t.boolean :client_work
      t.string :github
      t.string :website
      t.string :screencast
    end
  end
end
