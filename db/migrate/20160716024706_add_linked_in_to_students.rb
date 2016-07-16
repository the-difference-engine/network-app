class AddLinkedInToStudents < ActiveRecord::Migration
  def change
    add_column :students, :linked_in, :string
  end
end
