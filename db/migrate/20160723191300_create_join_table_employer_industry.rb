class CreateJoinTableEmployerIndustry < ActiveRecord::Migration
  def change
    create_join_table :employers, :industries do |t|
      # t.index [:employer_id, :industry_id]
      # t.index [:industry_id, :employer_id]
    end
  end
end
