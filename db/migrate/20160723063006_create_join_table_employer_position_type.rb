class CreateJoinTableEmployerPositionType < ActiveRecord::Migration
  def change
    create_join_table :employers, :position_types do |t|
      # t.index [:employer_id, :position_type_id]
      # t.index [:position_type_id, :employer_id]
    end
  end
end
