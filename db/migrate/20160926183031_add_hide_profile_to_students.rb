class AddHideProfileToStudents < ActiveRecord::Migration
  def change
    add_column :students, :hide_profile, :boolean, default: false
    add_column :employers, :hide_profile, :boolean, default: false
    add_column :admins, :hide_profile, :boolean, default: false
  end
end
