class AddActiveToStudents < ActiveRecord::Migration
  def change
    add_column :students, :active, :boolean, default: false
    add_column :employers, :active, :boolean, default: false
    add_column :admins, :active, :boolean, default: false
  end
end
