class CreateJoinTableEmployerPosition < ActiveRecord::Migration
  def change
    create_join_table :employers, :positions do |t|
      # t.index [:employer_id, :position_id]
      # t.index [:position_id, :employer_id]
    end
  end
end
