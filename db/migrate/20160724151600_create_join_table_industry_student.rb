class CreateJoinTableIndustryStudent < ActiveRecord::Migration
  def change
    create_join_table :industries, :students do |t|
      # t.index [:industry_id, :student_id]
      # t.index [:student_id, :industry_id]
    end
  end
end
