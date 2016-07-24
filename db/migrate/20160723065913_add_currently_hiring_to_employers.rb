class AddCurrentlyHiringToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :currently_hiring, :boolean, default: false
    add_column :employers, :hiring_timeline, :string
    add_column :employers, :number_of_positions, :integer
  end
end
