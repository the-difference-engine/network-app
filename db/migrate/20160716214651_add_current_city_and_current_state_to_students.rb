class AddCurrentCityAndCurrentStateToStudents < ActiveRecord::Migration
  def change
    add_column :students, :current_city, :string
    add_column :students, :current_state, :string
  end
end
