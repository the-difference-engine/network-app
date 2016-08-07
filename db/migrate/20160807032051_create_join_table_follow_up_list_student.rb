class CreateJoinTableFollowUpListStudent < ActiveRecord::Migration
  def change
    create_join_table :follow_up_lists, :students do |t|
      # t.index [:follow_up_list_id, :student_id]
      # t.index [:student_id, :follow_up_list_id]
    end
  end
end
