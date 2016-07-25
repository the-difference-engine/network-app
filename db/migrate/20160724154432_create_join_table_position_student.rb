class CreateJoinTablePositionStudent < ActiveRecord::Migration
  def change
    create_join_table :positions, :students do |t|
      # t.index [:position_id, :student_id]
      # t.index [:student_id, :position_id]
    end
  end
end
