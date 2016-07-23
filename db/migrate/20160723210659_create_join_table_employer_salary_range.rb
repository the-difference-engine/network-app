class CreateJoinTableEmployerSalaryRange < ActiveRecord::Migration
  def change
    create_join_table :employers, :salary_ranges do |t|
      # t.index [:employer_id, :salary_range_id]
      # t.index [:salary_range_id, :employer_id]
    end
  end
end
