class ChangeCapstoneAndClientWorkInProjects < ActiveRecord::Migration
  def change
    change_column :projects, :capstone, :boolean, default: false
    change_column :projects, :client_work, :boolean, default: false
  end
end
